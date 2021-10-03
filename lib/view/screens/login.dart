
import 'package:birdy_app/view/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'forgetpassword.dart';

class Login extends StatefulWidget {
  static const id='login';
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus;
        currentFocus=FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }},
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              //height: 700,
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/8),
              child: Column(

                children: <Widget>[
                  Image(image: AssetImage('assets/images/robin0.png')),
                  Text("Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color(0xfff79281),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.064,),
                  Form(
                    key: _formKey,
                     child: Column(
                       children: [
                         FormDesign(title: "Enter your Email", icon: Icons.email_outlined, controllerValue: emailController,),
                         SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                         FormDesign(title: "Enter Password", icon: Icons.lock,controllerValue: passwordController,),
                       ],
                     ),
                  ),
                  FlatButton(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.height*0.27),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPassword()),
                        );

                      },
                      child: Text("forget Password?",
                        style: TextStyle(
                          color: Color(0xfff79281),
                        ),
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: MediaQuery.of(context).size.height*0.07,
                    child: RaisedButton(onPressed: (){

                        if (_formKey.currentState!.validate()) {
                          print(emailController.text);
                          print(passwordController.text);
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Processing Data')),
                  // );
                }
              },

                      shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(10)),
                      color: Color(0xfff79281),
                      child: Text("Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal
                      ),
                      ),

                    ),

                  ),
                  FlatButton(//padding: EdgeInsets.only(left: MediaQuery.of(context).size.height*0.27),
                      onPressed: (){},
                      child: Text("i havn't an account",
                        style: TextStyle(
                          color: Color(0xfff79281),
                        ),
                      )),



                ],
              )
              // child: Column(
              //
              //   // mainAxisAlignment: MainAxisAlignment.center,
              //   // crossAxisAlignment: CrossAxisAlignment.center,
              //   children:<Widget>[
              //
              //     Center(
              //       child: Container(
              //         width: double.infinity,
              //         color: Colors.black,
              //       ),
              //     )
              //
              //
              //   ],
              // ),
            ),
          ),
        ),
      ),
    );
  }
}


// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   _LoginState createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Form(
//               key: _formKey,
//               child: FormDesign(title: "hgshsg", iccon: Icons.description,),
//             ),
//         SizedBox(
//           width: MediaQuery.of(context).size.width*0.8,
//           height: MediaQuery.of(context).size.height*0.07,
//           child: RaisedButton(onPressed: (){
//     if (_formKey.currentState!.validate()) {
//                   // If the form is valid, display a snackbar. In the real world,
//                   // you'd often call a server or save the information in a database.
//                   // ScaffoldMessenger.of(context).showSnackBar(
//                   //   const SnackBar(content: Text('Processing Data')),
//                   // );
//                 }
//               },
//
//           //},
//             shape: RoundedRectangleBorder(
//
//                 borderRadius: BorderRadius.circular(10)),
//             color: Color(0xfff79281),
//             child: Text("Login",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.normal
//               ),
//             ),
//
//           ),
//         ),
//           ],
//         ),
//       ),
//     );
//   }
// }
