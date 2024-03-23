import 'package:flutter/material.dart';

class UserData {
  final String name;
  final int age;
  final bool married;
  final String username;
  final String email;
  final String password;

  UserData({
    required this.name,
    required this.age,
    required this.married,
    required this.username,
    required this.email,
    required this.password,
  });

  void printData() {
    print('Name: $name');
    print('Age: $age');
    print('Married: $married');
    print('Username: $username');
    print('Email: $email');
    print('Password: $password');
  }
}
