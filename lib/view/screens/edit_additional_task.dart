import 'package:birdy_app/view/widgets/datepicker_calender.dart';
import 'package:flutter/material.dart';

import 'package:birdy_app/model/additional_task_model.dart';

class EditAdditionalTask extends StatefulWidget {
  List<AdditionalTask_model> tasks;
  EditAdditionalTask({required this.tasks});

  @override
  _EditAdditionalTaskState createState() => _EditAdditionalTaskState();
}

class _EditAdditionalTaskState extends State<EditAdditionalTask> {
  //List<AdditionalTask_model> additional_task=widget.tasks;
  List<bool> ispressed = [false, false, false, false, false, false, false];
  List days = ["M", "T", "W", "T", "F", "S", "s"];
  final newTaskName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(
            top: height * 0.08, left: width * 0.03, right: width * 0.03),
        children: [
          Text(
            "Additional Tasks",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          getAdditional_widget(),
        ],
      ),
    );
  }

  Widget getAdditional_widget() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.tasks
            .map((item) =>
                taskCard(item.taskName, item.room, item.cage, item.appointment))
            .toList());
    //additional_task.map((item) => DailyTasksCard(id: item.id,taskName: item.taskName,description: item.description,place: item.place,isdone: item.isDone,)).toList());
  }

  Widget taskCard(name, room, cage, appointment) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01),
      child: Container(
        width: MediaQuery.of(context).size.width,
        //height: 80,
        decoration: BoxDecoration(
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
        child: ListTile(
          title: Text(
            name,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w800),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$room, $cage",
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.001,
              ),
              Text(
                "$appointment",
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              )
            ],
          ),
          trailing: FlatButton(
            onPressed: () {
              alert_to_add_task();
            },
            child: Text(
              "Edit",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  alert_to_add_task() {
    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                title: Text("Edit your Task"),
                content: SingleChildScrollView(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: newTaskName,
                        maxLength: 30,
                        decoration: InputDecoration(
                          labelText: "Task's Name",
                          hintStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xfff79281), width: 0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xfff79281), width: 0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                        ),
                      ),
                      Text(
                        " choose Appointment",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        children: [
                          for (int index = 0; index < 7; index++)
                            GestureDetector(
                              child: ispressed[index]
                                  ? preesedButton(index)
                                  : unpressedButton(index),

                              onTap: () {
                                setState(() {
                                  ispressed[index] = !ispressed[index];
                                  //print("pres is$ispressed");
                                });
                              },

                              // onTapDown: (_) {
                              //   pressing = true;
                              // },
                              // onTapUp: (_) {
                              //   pressing = false;
                              // }
                            ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.027,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "OR: ",
                          ),
                          DatePicker()
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  Row(
                    children: [
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        textColor: Theme.of(context).primaryColor,
                        child: const Text('cancel'),
                      ),
                      new FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // cageProvider
                          //     .addCage(newCageName);
                          // setState(() {
                          //   newCageName = '';
                          // });
                        },
                        textColor: Theme.of(context).primaryColor,
                        child: const Text('Add'),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  )
                ],
              ),
            ));
  }

  preesedButton(index) {
    return Padding(
      padding: EdgeInsets.all(1),
      child: Container(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            days[index],
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w700),
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
              boxShadow: [
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 7.0,
                    spreadRadius: .4),
                BoxShadow(
                    color: Colors.grey.shade500,
                    offset: Offset(-2.0, -2.0),
                    blurRadius: 15.0,
                    spreadRadius: .4),
              ],
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey.shade600,
                    Colors.grey.shade500,
                    Colors.grey.shade400,
                    Colors.grey.shade200,
                  ],
                  stops: [
                    0,
                    0.1,
                    0.3,
                    1
                  ])),
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade500,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 15.0,
                  spreadRadius: .4),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(-2.0, -2.0),
                  blurRadius: 15.0,
                  spreadRadius: .4),
            ],
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey.shade200,
                  Colors.grey.shade300,
                  Colors.grey.shade400,
                  Colors.grey.shade500,
                ],
                stops: [
                  0.1,
                  0.3,
                  0.8,
                  1
                ])),
      ),
    );
  }

  unpressedButton(index) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text(
          days[index],
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
            border: (Border.all(color: Theme.of(context).primaryColor)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade600,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 7.0,
                  spreadRadius: .4),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(-2.0, -2.0),
                  blurRadius: 7.0,
                  spreadRadius: .4),
            ],
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey.shade200,
                  Colors.grey.shade300,
                  Colors.grey.shade400,
                  Colors.grey.shade500,
                ],
                stops: [
                  0.1,
                  0.3,
                  0.8,
                  1
                ])),
      ),
    );
  }
}
