import 'package:flutter/material.dart';

class NewCardTask extends StatefulWidget {
  double width;
  double height;
  String taskname;
  String room_name;
  String cage_name;
  bool done;
  NewCardTask({required this.width,required this.height,required this.taskname,required this.room_name,required this.cage_name,this.done=false});

  @override
  _NewCardTaskState createState() => _NewCardTaskState();
}

class _NewCardTaskState extends State<NewCardTask> {
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding:  EdgeInsets.all(widget.height*.01),
      child: Container(
          width: widget.width*.6,
          height:widget.height*.07,
          //height: 80,
          decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0, // soften the shadow
                  spreadRadius: 0.0, //extend the shadow
                )
              ]),child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  widget.done?  Text('Task: ${widget.taskname}'):SizedBox(),
                  Text('Room: ${widget.room_name}'),
                  Text('Cage: ${widget.cage_name} '),
                ],
              )),
    );
  }
}
