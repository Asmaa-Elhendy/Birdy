import 'package:birdy_app/view/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const String signupId='sign up';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController name_con =TextEditingController();
   TextEditingController phone_con =TextEditingController();
   TextEditingController email_con =TextEditingController();
   TextEditingController password_con =TextEditingController();

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
      FocusScopeNode currentFocus;
      currentFocus=FocusScope.of(context);
      if(!currentFocus.hasPrimaryFocus){
        currentFocus.unfocus();
      }
      },
      child: Scaffold(


       // resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 SizedBox(height: MediaQuery.of(context).size.height*1/7,),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Center(
                    child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/robin0.png'),
                            Text('Create an Account' ,style: TextStyle(color: Color(0xfff79281),fontWeight: FontWeight.bold,fontSize: 25),),
                           FormDesign(title: 'name', icon: Icons.account_circle_rounded, controllerValue: name_con),
                            FormDesign(title: 'Phone Number', icon: Icons.phone, controllerValue: phone_con),
                           FormDesign(title: 'Email Address', icon: Icons.email_outlined, controllerValue: email_con),
                           FormDesign(title: 'Password', icon: Icons.lock_open,controllerValue:password_con ),

                          ],

                      ),
                  ),
                ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xfff79281),),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                        )),
                    onPressed: () {
                      Navigator.pushNamed(context, Dashboard.dashboardid);
                      print('${name_con.text} name' );
                      print('${phone_con.text} phone' );
                      print('${email_con.text} email' );
                      print('${password_con.text} password');
                    if(_formKey.currentState!.validate()){
                       Navigator.pushNamed(context, SignUp.signupId);
                    }
                    },
                    child: Text('create an account',style: TextStyle(fontSize: 15),),
                  ),
                ],
              ),
          ),

        ),

    );
  }
}
