import 'package:bike_customerv2/Customer/screen/login/login_screen.dart';
import 'package:bike_customerv2/Customer/screen/mainScreen.dart';
import 'package:bike_customerv2/Customer/screen/mainScreen.dart';
import 'package:bike_customerv2/Customer/screen/user/editProfile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isNewUser = false;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isNewUser ? editProfile() : LoginPage(),
    );
  }
}
