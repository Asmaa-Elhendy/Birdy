import 'package:birdy_app/controller/providers/cage_provider.dart';
import 'package:birdy_app/controller/providers/dailytasks_provider.dart';
import 'package:birdy_app/controller/providers/weekdays_provider.dart';
import 'package:birdy_app/view/screens/dashboard.dart';
import 'package:birdy_app/view/screens/forgetpassword.dart';
import 'package:birdy_app/view/screens/login.dart';
import 'package:birdy_app/view/screens/signup.dart';
import 'package:birdy_app/view/screens/start.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/providers/additional_task_provider.dart';
import 'controller/providers/bird_provider.dart';
import 'controller/providers/new_daily_task_controller.dart';
import 'controller/providers/new_daily_task_controller_saved_to_db.dart';
import 'controller/providers/rooms_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
       ChangeNotifierProvider( create: (_)=>Rooms_Provider(),),
        ChangeNotifierProvider( create: (_)=>CageProvider(),),
        ChangeNotifierProvider(create: (_)=>DailyTasksProvider()),
        ChangeNotifierProvider(create: (context)=>AdditionalTaskProvider()),
        ChangeNotifierProvider(create: (_)=>Weekdays()),
        ChangeNotifierProvider(create: (_)=>DailyTaskController()),
        ChangeNotifierProvider(create: (context)=>BirdProvider()),
        ChangeNotifierProvider(create: (_)=>DailyTaskControllerSavedToDB())
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Birdy',
        theme: ThemeData(
          primaryColor: Color(0xfff79281),

        ),
        home: Start(),
        routes: {
          SignUp.signupId:(context)=>SignUp(),
          Login.id:(context)=>Login(),
          ForgetPassword.id:(context)=>ForgetPassword(),
          Dashboard.dashboardid:(context)=>Dashboard(),


        },
      ),
    );
  }
}
