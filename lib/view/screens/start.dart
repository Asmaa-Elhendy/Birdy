import 'package:birdy_app/view/screens/login.dart';
import 'package:birdy_app/view/screens/signup.dart';
import 'package:birdy_app/view/widgets/animated_page_route.dart';
import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Welcome to Birdy',style: TextStyle(fontWeight: FontWeight.bold,fontSize:25,color: Color(0xfff79281
            )),),
            Image.asset('assets/images/bird.png'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  )),
                  onPressed: () {
                    Navigator.of(context).push( createRoute(SignUp()));
                  },
                child: Text('SIGN UP',style: TextStyle(color: Color(0xfff79281),),),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xfff79281)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),

                          )
                      )),
                  onPressed: () {
                    Navigator.of(context).push( createRoute(Login()));
                  },
                  child: Text('LOGIN '),

                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
