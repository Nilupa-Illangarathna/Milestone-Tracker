import '../data_classes/global_data_class.dart';
import '../data_classes/sub classes/user_profile_data.dart';
import '../data_instance_creation.dart';
import 'package:http/http.dart' as http;

import '../global/api_caller.dart';


UserData userDataOBJ = UserData(name: '', age: 0, username: '', email: '', mobile: '', password: '');
GlobalData global_user_data_OBJ = generateRandomGlobalData(numberOfDummyGoals:0, userDataOBJ: userDataOBJ);




Future<GlobalData?> getGlobalData({required UserData userDataOBJ}) async {
  try {
    final response = await apiCaller.callApi('get_global_data', userDataOBJ.toJson());
    print("send data is : " );
    print(response?['globalDataFromDatabase']);
    if (response != null) {
      // Check if globalDataFromDatabase exists and is not null
      if (response['globalDataFromDatabase'] != null) {
        // Parse the response data and return the GlobalData object
        print("recived data is : " );
        print(GlobalData.fromJson(response['globalDataFromDatabase']));
        return GlobalData.fromJson(response['globalDataFromDatabase']);
      } else {
        // Handle the case where globalDataFromDatabase is null
        print('Received global data is null');
        // Return null or handle the error appropriately
        return null;
      }
    } else {
      print('Failed to fetch global data: ${response?['message']}');
      return generateRandomGlobalData(numberOfDummyGoals:0, userDataOBJ: userDataOBJ);
    }
  } catch (e) {
    print('Exception while fetching global data: $e');
    return generateRandomGlobalData(numberOfDummyGoals:0, userDataOBJ: userDataOBJ);
  }
}



//TODO call thi to save globalData
// New method to send global data
Future<String> sendGlobalData({required GlobalData globalData}) async {
  try {
    Map<String, dynamic>? response = await apiCaller.callApi('update_global_data', globalData.toJson());


    if (response != null) {
      // Login successful
      print('Saving successful. User data: ${response['user']}');
      return "success";

    }  else {
        print('Saving unsuccessful. User data: ${response?['user']}');
        return "fail";
    }
  } catch (e) {
    print('Exception while sending global data: $e');
    return "exception";
  }
}

