
import 'package:birdy_app/view/screens/email_confirm.dart';
import 'package:birdy_app/view/widgets/animated_page_route.dart';
import 'package:birdy_app/view/widgets/textfield.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  static const id='forget';
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            //height: 700,
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/8),
              child: Column(

                children: <Widget>[
                  Image(image: AssetImage('assets/images/robin0.png')),
                  Text("Forget Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color(0xfff79281),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.064,),
                  Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      children: [
                        FormDesign(title: 'Email Address', icon: Icons.email_outlined,controllerValue: emailController,),

                      ],
                    ),
                  ),
                  // FormDesign(title: "Your email",iccon:Icons.email_outlined),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),

                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: MediaQuery.of(context).size.height*0.07,
                    child: RaisedButton(onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        print(emailController.text);
                        Navigator.of(context).push(createRoute(EmailConfirm()));
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
                      child: Text("Forget Password",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal
                        ),
                      ),

                    ),

                  ),




                ],
              )

          ),
        ),
      ),
    );
  }
}
