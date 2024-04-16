const express = require('express');
const bodyParser = require('body-parser');
const UserData = require('./data_classes/user_data');
const { createClient } = require('@supabase/supabase-js');
const {
    createRecord,
    readRecord,
    updateRecord,
    deleteRecord,
    crud,
    login_post_method,
    signup_post_method,
    sendOTP,
    verifyOTP,
    reset_pass_function
} = require('./auth_operations');
// // index.js
const { create, read, update, del, executeQuery } = require('./db_operations');


const app = express();
const port = 3500;

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

const supabaseUrl = 'https://zqjmkicfcolipzkqvslv.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inpxam1raWNmY29saXB6a3F2c2x2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDg4NjA2MDYsImV4cCI6MjAyNDQzNjYwNn0.okYMPvmrR8ftOXIyHYIJ2DQ-Tk2ZfVZhHXMM6cBmaVk';
const supabase = createClient(supabaseUrl, supabaseKey);


// Login route
app.post('/login', async (req, res) => {
    let { username, password } = req.body;

    try {
        const result = await login_post_method(username, password);
        res.json(result);
    } catch (error) {
        console.error('Error occurred during login:', error);
        res.status(500).json({ success: false, message: 'An error occurred. Please try again later.' });
    }
});

// Signup route
app.post('/signup', async (req, res) => {
    const { name, age, username, email, mobile, password } = req.body;

    try {
        const result = await signup_post_method(name, age, username, email, mobile, password);
        res.json(result);
    } catch (error) {
        console.error('Error occurred during signup:', error);
        res.status(500).json({ success: false, message: 'An error occurred. Please try again later.' });
    }
});

// Send OTP route
app.post('/send_otp', async (req, res) => {
    const { method, contact, isNumericOTP, otpDigitCount, otpCountdownTime } = req.body;

    try {
        const result = await sendOTP(contact, method, isNumericOTP, otpDigitCount);
        res.json(result);
    } catch (error) {
        console.error('Error occurred while sending OTP:', error);
        res.status(500).json({ success: false, message: 'An error occurred. Please try again later.' });
    }
});

// Verify OTP route
app.post('/verify_otp', async (req, res) => {
    const { method, contact, otp } = req.body;

    try {
        const result = await verifyOTP(method, contact, otp);
        res.json(result);
    } catch (error) {
        console.error('Error occurred while verifying OTP:', error);
        res.status(500).json({ success: false, message: 'An error occurred. Please try again later.' });
    }
});

// Reset password route
app.post('/reset_password', async (req, res) => {
    const { method, contact, password } = req.body;

    try {
        reset_pass_function(method, contact, password, res);
    } catch (error) {
        console.error('Error occurred while resetting password:', error.message);
        res.status(500).json({ success: false, message: 'An error occurred. Please try again later.' });
    }
});
// FIXME: above is completed


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function to create or retrieve user UUID based on username and password


const ID_table = "goalkeepingapp_users_ids"

function generateUniqueID() {
    // Generate a random number and convert it to base 36
    const randomNumber = Math.random().toString(36).substring(2);
    // Generate a timestamp and convert it to base 36
    const timestamp = (new Date()).getTime().toString(36);
    // Concatenate the random number and timestamp to create a unique ID
    const uniqueID = randomNumber + timestamp;
    return uniqueID;
}


async function getUserUUID(username, password) {
    try {
      // Check if the user with the provided username and password exists
      const { data: existingUsers, error } = await supabase
        .from(ID_table)
        .select('uuid')
        .eq('username', username)
        .eq('password', password);
  
      if (error) {
        console.error('Error checking for existing user:', error.message);
        return { error: 'Internal server error' };
      }
  
      if (existingUsers && existingUsers.length > 0) {
        // User already exists, return the UUID
        return { uuid: existingUsers[0].uuid };
      } else {
        // User doesn't exist, generate a unique ID and save it
        const newUuid = generateUniqueId();
  
        // Insert the new user with the generated UUID
        const { data: newUser, error: insertError } = await supabase
          .from(ID_table)
          .insert([{ username, password, uuid: newUuid }]);
  
        if (insertError) {
          console.error('Error inserting new user:', insertError.message);
          return { error: 'Internal server error' };
        }
  
        // Return the generated UUID for the new user
        return { uuid: newUser[0].uuid };
      }
    } catch (e) {
      console.error('Exception occurred:', e);
      return { error: 'Internal server error' };
    }
  }
  
// TODO: save data
  async function saveGlobalData(globalData, uniqueId) {
    try {
        // Check if the document with the unique ID exists in MongoDB
        const existingData = await read('goal_setting', { uuid: uniqueId });
        if (existingData.length > 0) {
            // Document exists, update the document with the provided GlobalData
            await update('goal_setting', { uuid: uniqueId }, { globalData });
        } else {
            // Document doesn't exist, create a new document with the provided GlobalData and unique ID
            await create('goal_setting', { uuid: uniqueId, globalData });
        }
    } catch (error) {
        console.error('Error while saving GlobalData:', error);
        throw error;
    }
}
// TODO: Get data
async function getGlobalData(uniqueId) {
    try {
        // Read the document with the provided unique ID from MongoDB
        const data = await read('goal_setting', { uuid: uniqueId });
        if (data.length > 0) {
            // Document found, return the GlobalData
            return data[0].globalData;
        } else {
            // Document not found, return null
            console.log('No data found for the provided unique ID:', uniqueId);
            return null;
        }
    } catch (error) {
        console.error('Error while fetching GlobalData:', error);
        throw error;
    }
}


app.post('/update_global_data', async (req, res) => {
    try {
        // Extract username and password from userData
        const { username, password } = req.body.userData;
        const globalData = req.body;

        // Print username and password on CLI
        console.log('Username:', username);
        console.log('Password:', password);

        const uniqueId = await getUserUUID(username, password);

        await saveGlobalData(globalData, uniqueId);

        // Send response
        res.json({ success: true, uuid , message: 'Data received successfully.' });
    } catch (error) {
        // Handle any errors here
        console.error('Error in /update_data:', error);
        res.status(500).json({ success: false, message: 'An error occurred while processing the request.' });
    }
});


// Endpoint to send global data to frontend based on username and password
app.post('/get_global_data', async (req, res) => {
    try {
        // Extract username and password from request body
        const { username, password } = req.body;

        const uniqueId = await getUserUUID(username, password);

        const globalDataFromDatabase =  await getGlobalData(uniqueId);


        if (globalDataFromDatabase) {
            // Send global data as JSON response

            console.log("Recived data are : ", globalDataFromDatabase);
            res.json({ globalDataFromDatabase });
        } else {
            res.status(404).json({ success: false, message: 'Global data not found for the provided username and password.' });
        }
    } catch (error) {
        console.error('Error in /global_data:', error);
        res.status(500).json({ success: false, message: 'An error occurred while fetching global data.' });
    }
});



// Start the server
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});

















// const userData = {
//     "username": "john_doe",
//     "age": 35,
//     "goals": [
//         {
//             "name": "Learn MongoDB",
//             "start_date": "2024-01-01",
//             "end_date": "2024-06-30",
//             "tasks": [
//                 {
//                     "task_name": "Read MongoDB documentation",
//                     "priority": "high",
//                     "status": "incomplete"
//                 },
//                 {
//                     "task_name": "Complete MongoDB course",
//                     "priority": "medium",
//                     "status": "complete"
//                 }
//             ]
//         },
//         {
//             "name": "Exercise regularly",
//             "start_date": "2024-03-01",
//             "end_date": "2024-12-31",
//             "tasks": [
//                 {
//                     "task_name": "Go for a jog",
//                     "priority": "medium",
//                     "status": "complete"
//                 },
//                 {
//                     "task_name": "Join a gym",
//                     "priority": "high",
//                     "status": "incomplete"
//                 }
//             ]
//         }
//     ]
// };



// const anotherUserData = {
//     "username": "jane_smith",
//     "age": 28,
//     "goals": [
//         {
//             "name": "Learn Python",
//             "start_date": "2024-02-15",
//             "end_date": "2024-08-31",
//             "tasks": [
//                 {
//                     "task_name": "Complete Python crash course",
//                     "priority": "high",
//                     "status": "complete"
//                 },
//                 {
//                     "task_name": "Practice Python coding challenges",
//                     "priority": "medium",
//                     "status": "incomplete"
//                 }
//             ]
//         },
//         {
//             "name": "Read more books",
//             "start_date": "2024-01-01",
//             "end_date": "2024-12-31",
//             "tasks": [
//                 {
//                     "task_name": "Read 'The Great Gatsby'",
//                     "priority": "medium",
//                     "status": "complete"
//                 },
//                 {
//                     "task_name": "Read 'To Kill a Mockingbird'",
//                     "priority": "high",
//                     "status": "incomplete"
//                 }
//             ]
//         }
//     ]
// };



// // index.js
// const { create, read, update, del, executeQuery } = require('./db_operations');



// async function createUserData(userId, userData) {
//     try {
//         console.log("\nInserting user data...");
//         const createdUserData = await create('users', { userId, ...userData });
//         console.log("Inserted user data:", createdUserData);
//     } catch (error) {
//         console.error("Error:", error);
//     }
// }



// async function readUserData(userId) {
//     try {
//         console.log("\nReading user data...");
//         const userData = await read('users', { userId: userId });
//         console.log("Retrieved user data:", userData);
//         return userData;
//     } catch (error) {
//         console.error("Error:", error);
//         throw error;
//     }
// }


// async function updateUserData(userId, newData) {
//     try {
//         console.log("\nUpdating user data...");
//         const updatedData = await update('users', { userId: userId }, { $set: newData });
//         console.log("Updated user data:", updatedData);
//     } catch (error) {
//         console.error("Error:", error);
//     }
// }


// async function deleteUserData(userId) {
//     try {
//         console.log("\nDeleting user data...");
//         const deletedData = await del('users', { userId: userId });
//         console.log("Deleted user data:", deletedData);
//     } catch (error) {
//         console.error("Error:", error);
//     }
// }






// createUserData(anotherUserData);
// // readUserData("Nick123!@#");
// // updateUserData("Nick123!@#", newUserData);
// // deleteUserData("Nick123!@#");