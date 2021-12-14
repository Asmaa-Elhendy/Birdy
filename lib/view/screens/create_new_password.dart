import 'package:birdy_app/view/widgets/textfield.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({Key? key}) : super(key: key);

  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  TextEditingController passwordController =TextEditingController();
  TextEditingController confirmPasswordController =TextEditingController();
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return GestureDetector(
      onTap: (){
      FocusScopeNode currentFocus;
      currentFocus=FocusScope.of(context);
      if(!currentFocus.hasPrimaryFocus){
        currentFocus.unfocus();
      }
    },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: height*.1,bottom: height*.06),
                  child: Text('Create new password',style: TextStyle(color: Color(0xfff79281),fontWeight: FontWeight.bold,fontSize: 25),),
                ),Form(
                  key: _formKey,

                    child: Column(
                  children: [
                    FormDesign(title:'Password',icon:Icons.password ,controllerValue: passwordController ,),
                    FormDesign(title:'Confirm Password',icon:Icons.password ,controllerValue: confirmPasswordController ,),

                  ],

                )),
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: height*.06),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xfff79281),),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                        )),
                    onPressed: () {

                      if(_formKey.currentState!.validate()){
                        Navigator.pushNamed(context, Dashboard.dashboardid);
                      }
                    },
                    child: Text('create new password',style: TextStyle(fontSize: 15),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
