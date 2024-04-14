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