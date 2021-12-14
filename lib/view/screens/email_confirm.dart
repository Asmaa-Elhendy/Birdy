import 'package:birdy_app/view/screens/create_new_password.dart';
import 'package:birdy_app/view/widgets/animated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EmailConfirm extends StatelessWidget {
  const EmailConfirm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    final String requiredNumber = '123456';
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(top: height * 0.1),
        child: Center(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: width * .04),
            child: Column(
              children: [
                Text("Check Your email and enter code you received",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: height*0.1,),
                PinCodeTextField(
                    appContext: context,
                    length: 6,
                  onChanged: (value) {
                    print(value);

                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.circle,
                    fieldHeight: 50,
                    fieldWidth: 40,
                    inactiveColor: Colors.grey,
                    selectedColor: Theme.of(context).primaryColor,
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  onCompleted: (value){
                    if(value == requiredNumber){
                      print('valid pin');
                      Navigator.of(context).push(createRoute(CreateNewPassword()));
                    } else {
                      print('invalid pin');
                    }
                  },

                )

              ],
            ),
          ),
        ),
      ),

    );
  }
}




// import 'package:birdy_app/view/widgets/otp_form.dart';
// import 'package:flutter/material.dart';
//
// class EmailConfirm extends StatefulWidget {
//   const EmailConfirm({Key? key}) : super(key: key);
//
//   @override
//   _EmailConfirmState createState() => _EmailConfirmState();
// }
//
// class _EmailConfirmState extends State<EmailConfirm> {
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery
//         .of(context)
//         .size
//         .width;
//     double height = MediaQuery
//         .of(context)
//         .size
//         .height;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(top: height*0.1),
//               child: Text(
//                 "Check your email and enter code you received ",
//                 style: TextStyle(
//                     color: Theme.of(context).primaryColor,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18
//                 ),
//               ),
//             ),
//             SizedBox(height: height*0.015,),
//             CountDown(),
//             OtpForm()
//             ],
//         ),
//       ),
//     );
//   }
//   Row CountDown(){
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("This code will expired in ",
//           style: TextStyle(
//             fontSize: 16
//           ),
//
//         ),
//         TweenAnimationBuilder(
//           tween: Tween(begin: 30.0, end: 0.0),
//           duration: Duration(seconds: 30),
//           builder: (_, dynamic value, child) => Text(
//             "00:${value.toInt()}",
//             style: TextStyle(color: Colors.purple),
//           ),
//         ),
//       ],
//     );
//   }
// }
