import 'package:birdy_app/view/screens/dashboard.dart';
import 'package:birdy_app/view/screens/forgetpassword.dart';
import 'package:birdy_app/view/screens/login.dart';
import 'package:birdy_app/view/screens/signup.dart';
import 'package:birdy_app/view/screens/start.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primaryColor: Color(0xfff79281),

      ),
      home: Start(),
      routes: {
        SignUp.signupId:(context)=>SignUp(),
        Login.id:(context)=>Login(),
        ForgetPassword.id:(context)=>ForgetPassword(),
        Dashboard.dashboardid:(context)=>Dashboard()

      },
    );
  }
}
