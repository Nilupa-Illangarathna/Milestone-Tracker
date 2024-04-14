import 'dart:convert';

// UserData Class
class UserData {
  String name;
  int age;
  String username;
  String email;
  String mobile;
  String password;

  // Constructor
  UserData({
    required this.name,
    required this.age,
    required this.username,
    required this.email,
    required this.mobile,
    required this.password,
  });

  // Getters and Setters

  // Name
  String get getName => name;
  set setName(String value) => name = value;

  // Age
  int get getAge => age;
  set setAge(int value) => age = value;

  // Username
  String get getUsername => username;
  set setUsername(String value) => username = value;

  // Email
  String get getEmail => email;
  set setEmail(String value) => email = value;

  // Mobile
  String get getMobile => mobile;
  set setMobile(String value) => mobile = value;

  // Password
  String get getPassword => password;
  set setPassword(String value) => password = value;

  // Serialization Method
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'username': username,
      'email': email,
      'mobile': mobile,
      'password': password,
    };
  }

  // Deserialization Method
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      age: json['age'],
      username: json['username'],
      email: json['email'],
      mobile: json['mobile'],
      password: json['password'],
    );
  }

  // Print Method
  void printData() {
    print('User Data:');
    print('Name: $name');
    print('Age: $age');
    print('Username: $username');
    print('Email: $email');
    print('Mobile: $mobile');
    // Avoid printing password for security reasons
  }
}
