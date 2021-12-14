import 'package:birdy_app/controller/providers/cage_provider.dart';
import 'package:birdy_app/view/screens/dashboard.dart';
import 'package:birdy_app/view/screens/forgetpassword.dart';
import 'package:birdy_app/view/screens/login.dart';
import 'package:birdy_app/view/screens/signup.dart';
import 'package:birdy_app/view/screens/start.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider( create: (_)=>CageProvider(),)

      ],

      child: MaterialApp(
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
          Dashboard.dashboardid:(context)=>Dashboard(),


        },
      ),
    );
  }
}
