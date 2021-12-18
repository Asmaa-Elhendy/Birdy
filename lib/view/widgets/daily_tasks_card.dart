import 'package:flutter/material.dart';
import 'package:birdy_app/controller/providers/dailytasks_provider.dart';
import 'package:provider/provider.dart';

class DailyTasksCard extends StatefulWidget {
  String id;
  String taskName;
  String description;
  String place;
  bool isdone;
  DailyTasksCard({required this.id,required this.taskName, required this.place, required this.description,required this.isdone});

  @override
  _DailyTasksCardState createState() => _DailyTasksCardState();
}

class _DailyTasksCardState extends State<DailyTasksCard> {
  bool value = false;
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
    DailyTasksProvider dailyTasks_provider = Provider.of<DailyTasksProvider>(context);



    return Padding(
      padding:  EdgeInsets.only(top: height * 0.02),
      child: Container(
        width: width,
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
          ],
        ),
        child: ExpansionTile(

          leading: Icon(Icons.fastfood,
            color: Theme.of(context).primaryColor,
          ),
            title: widget.isdone?Text(widget.taskName,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w800
              ),
            ):Row(

            children: [
              // IconButton(onPressed: ()=> dailyTasks_provider.makeTaskDone(widget.id),
              //     icon: Icon(Icons.check,
              //       color: Colors.red,
              //       size: 10,
              //     )),
              Checkbox(
                activeColor: Colors.red,
                value: value,

                onChanged: (value) {
                    setState(() {
                      this.value = !value!;

                    });
                    // setState(() {
                    //   this.value = !this.value;
                    //
                    // });
                    dailyTasks_provider.makeTaskDone(widget.id);



                },


              ),
              Text(widget.taskName,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w800
                ),
              ),
            ],
          ),
          subtitle:
              Text(widget.place,
                style: TextStyle(
                    color: Colors.grey[600],
                  fontSize: 16
                ),
              ),

             children: [
               ListTile(title: Text(widget.description,
                 textAlign: TextAlign.center,
                 style: TextStyle(
                   color: Colors.grey
                 ),

               )),
             ],
        ),
      ),
    );
  }
}
