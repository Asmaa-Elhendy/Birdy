import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class FormDesign extends StatefulWidget {
  String title;
  IconData icon;
  TextEditingController controllerValue;

  FormDesign(
      {Key? key,
      required this.title,
      required this.icon,
      required this.controllerValue})
      : super(key: key);

  @override
  _FormDesignState createState() => _FormDesignState();
}

class _FormDesignState extends State<FormDesign> {
  bool notVisible = true;


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.73,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          //   color: Color(0xfff79281).withOpacity(0.3),
        ),
        child: TextFormField(
            controller: widget.controllerValue,
            obscureText: widget.title == 'Password' ||widget.title=='Confirm Password'? notVisible : false,
            //  maxLength: 15,

            style: TextStyle(color: Colors.grey[600]),
            //hight
            keyboardType: widget.title == "Phone Number"
                ? TextInputType.phone
                : TextInputType.text,
            decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xfff79281).withOpacity(.3),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color(0xfff79281).withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color:Color(0xfff79281),
                    )),
                prefixIcon: Icon(
                  widget.icon,
                  color: Color(0xfff79281),
                ),
                suffixIcon: widget.title == 'Password'||widget.title=='Confirm Password'
                    ? IconButton(
                        icon: Icon(notVisible
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined),
                        onPressed: () {
                          setState(() {
                            notVisible = !notVisible;
                          });
                        },
                      )
                    : null,
                labelText: '${widget.title}',
                labelStyle: TextStyle(
                  color: Color(0xfff79281),
                  fontWeight: FontWeight.w800,
                )),
            validator: (value) {
              if (widget.title == 'Email Address') {
                if (EmailValidator.validate(value!)) {
                  return null;
                }
                if (value.length == 0) {
                  return "* please enter email";
                }
                return "* please enter valid email";
              }else if(widget.title=='Phone Number') {          //check 12 number
                RegExp phoneRegExp = new RegExp(
                  r"^01[0125][0-9]{8}$",                 //phone_number: ^0.12.0+1

                );
                if (value!.length == 0) {
                  return '* Please enter mobile number';
                }
                else if (!phoneRegExp.hasMatch(value)) {
                  return '* Please enter valid mobile number';
                }
                return null;
              }

              else {
                if (value == null || value.isEmpty) {
                  return '* Please enter ${widget.title}';
                }
                return null;
              }
            }),
      ),
    );
  }
}

