import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class FormDesign extends StatefulWidget {
  String title;
  IconData icon;
  TextEditingController controllerValue;


  FormDesign({Key? key,
    required this.title,
    required this.icon,
    required this.controllerValue
  }) : super(key: key);
  @override
  _FormDesignState createState() => _FormDesignState();
}

class _FormDesignState extends State<FormDesign> {


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return  Padding(
      padding:  EdgeInsets.symmetric(vertical: 8),
      child: Container(

        width: MediaQuery
            .of(context)
            .size
            .width * 0.73,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          //   color: Color(0xfff79281).withOpacity(0.3),
        ),
        child:  TextFormField(
        controller: widget.controllerValue,
          style: TextStyle(height: .2,color: Colors.grey[600]),
          decoration: InputDecoration(
              filled: true,
              fillColor:  Color(0xfff79281).withOpacity(.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.white
                ),

              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color:  Color(0xfff79281),)
              ),
              prefixIcon: Icon(widget.icon,
                color: Color(0xfff79281),
              ),
              labelText: '${widget.title}',
              labelStyle: TextStyle(
                color: Color(0xfff79281),
                fontWeight: FontWeight.w800,
              )
          ),validator:  (value) {
          if (value == null || value.isEmpty) {              //if(widget.title=='name'){ // validation on name}
            return '* Please enter ${widget.title}';
          }
          return null;
        },



        ),
      ),
    );
  }
}



