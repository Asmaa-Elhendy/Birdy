import 'package:flutter/material.dart';


class BirdForm extends StatefulWidget {
  String label;
  var icon;
  double size;
  TextEditingController controllerValue;

  BirdForm(
      {Key? key,
        required this.label,
        required this.icon,
        required this.controllerValue,
        required this.size,
      })
      : super(key: key);

  @override
  _BirdFormState createState() => _BirdFormState();
}

class _BirdFormState extends State<BirdForm> {
  bool isimage = false;

  @override
  Widget build(BuildContext context) {
    if(widget.label == "Bird Breed"|| widget.label == "Ring Type" || widget.label == "Ring Num"){
      setState(() {
        isimage = true;
      });
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: widget.size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          //   color: Color(0xfff79281).withOpacity(0.3),
        ),
        child: TextFormField(
          controller: widget.controllerValue,
          style: TextStyle(color: Colors.grey[600]),
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
            prefixIcon:isimage?
             ImageIcon(
               AssetImage(widget.icon),
               color: Theme.of(context).primaryColor,
               size: 0.002,
             )
            :Icon(
              widget.icon,
              color: Color(0xfff79281),
            ),
              labelText: '${widget.label}',
              labelStyle: TextStyle(
                color: Color(0xfff79281),
                fontWeight: FontWeight.w800,
              )),
          validator: (value){
            if (value == null || value.isEmpty) {
              return '* Please enter ${widget.label}';
            }
          },
        ),
      ),
    );
  }
}
