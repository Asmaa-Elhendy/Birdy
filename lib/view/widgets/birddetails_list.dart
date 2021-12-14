import 'package:flutter/material.dart';

class BirdDetailsList extends StatefulWidget {
  String title;
  String imageOrIcon;
  var icon;

   BirdDetailsList({Key? key,
    required this.icon,
     required this.imageOrIcon,
    required this.title
  }) : super(key: key);

  @override
  _BirdDetailsListState createState() => _BirdDetailsListState();
}

class _BirdDetailsListState extends State<BirdDetailsList> {
  @override
  Widget build(BuildContext context) {
    bool isimage = false;
    if(widget.imageOrIcon == "breed"|| widget.imageOrIcon == "gender" || widget.imageOrIcon == "ring"){
      setState(() {
        isimage = true;
      });
    }
    return ListTile(
      leading: isimage?
      ImageIcon(
        AssetImage(widget.icon),
        color: Theme.of(context).primaryColor,
        //size: 0.001,
      )
          :Icon(
        widget.icon,
        color: Color(0xfff79281),
      ),
      title: Text(widget.title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600
          ),
      ),

    );
  }
}
