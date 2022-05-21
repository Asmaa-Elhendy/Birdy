import 'package:birdy_app/controller/providers/additional_task_provider.dart';
import 'package:birdy_app/model/cage_model.dart';
import 'package:birdy_app/view/widgets/datepicker_calender.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:birdy_app/model/additional_task_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EditAdditionalTask extends StatefulWidget {
  Cage cage;
  EditAdditionalTask(this.cage);
  @override
  _EditAdditionalTaskState createState() => _EditAdditionalTaskState();
}

class _EditAdditionalTaskState extends State<EditAdditionalTask> {
  List<bool> ispressed = [false, false, false, false, false, false, false];
  List<bool> oldIspressed = [false, false, false, false, false, false, false];
  List daysWord = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  List days = ["M", "T", "W", "T", "F", "S", "S"];
  List selectedDays = [];

  final newTaskName = TextEditingController();
  DateTime? dateTime;

  @override
  void initState() {
    AdditionalTaskProvider additionalTaskProvider =
        Provider.of<AdditionalTaskProvider>(context, listen: false);
    additionalTaskProvider.readTaskByCageId(widget.cage.id);

    //additionalTaskProvider.readAllTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AdditionalTaskProvider additionalTaskProvider =
        Provider.of<AdditionalTaskProvider>(context);
    additionalTaskProvider.readTaskByCageId(widget.cage.id);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: height * 0.08, left: width * 0.03, right: width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Additional Tasks',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: additionalTaskProvider.needTasks.length,
                    itemBuilder: (context, index) {
                      return taskCard(
                          additionalTaskProvider.needTasks[index].taskName,
                          additionalTaskProvider.needTasks[index].roomName,
                          additionalTaskProvider.needTasks[index].cageName,
                          additionalTaskProvider.needTasks[index].appointment,
                          index,
                          additionalTaskProvider);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget getAdditional_widget() {
  //   return Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: widget.tasks
  //           .map((item) =>
  //               taskCard(item.taskName, item.roomId, item.cageId, item.appointment))
  //           .toList());
  //   //additional_task.map((item) => DailyTasksCard(id: item.id,taskName: item.taskName,description: item.description,place: item.place,isdone: item.isDone,)).toList());
  // }

  Widget taskCard(name, room, cage, appointment, index,
      AdditionalTaskProvider additionalTaskProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .11,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.0013,),

                      Text(
                        "Room: $room, Cage: $cage",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.007,),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            "at $appointment",
                            maxLines: 3,
                            style: TextStyle(color: Colors.grey[600], fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              FlatButton(
                onPressed: () async {
                  AdditionalTask_model oldTask =
                      await additionalTaskProvider.getAdditionalTask(
                          additionalTaskProvider.needTasks[index].id!);
                  print("my task dateis ${oldTask.appointment}");

                  if (RegExp(r'[A-Z]').hasMatch(oldTask.appointment)) {
                    print(" char");
                    String oldAppointment = oldTask.appointment;
                    List oldAppointmentList = splitFunc(oldAppointment);
                    setState(() {
                      oldIspressed = getTrueFalseList(oldAppointmentList);
                    });
                  } else {
                    print("not cahr");
                    String oldAppointmen = oldTask.appointment;
                    setState(() {
                      dateTime = DateTime.parse(oldAppointmen);
                      print("date is new  ${dateTime}");

                      //print("dateeee$dateTime");
                    });
                  }
                  alert_to_edit_task(additionalTaskProvider, oldTask);
                },
                child: Text(
                  "Edit",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  additionalTaskProvider.deleteTask(
                      additionalTaskProvider.needTasks[index].id!);
                },
                child: Text(
                  "Delete",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          )
          // child: ListTile(
          //   title: Text(
          //     name,
          //     style: TextStyle(
          //         color: Theme.of(context).primaryColor,
          //         fontSize: 18,
          //         fontWeight: FontWeight.w800),
          //   ),
          //   subtitle: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "Room: $room, Cage: $cage",
          //         style: TextStyle(color: Colors.grey[600], fontSize: 16,fontWeight: FontWeight.w600),
          //       ),
          //       SizedBox(
          //         height: MediaQuery.of(context).size.height * 0.003,
          //       ),
          //       Text(
          //         "at $appointment",
          //         style: TextStyle(color: Colors.grey[600], fontSize: 16),
          //       )
          //     ],
          //   ),
          //   trailing: Row(
          //     children: [
          //       FlatButton(
          //         onPressed: () {
          //           alert_to_add_task();
          //         },
          //         child: Text(
          //           "E",
          //           style: TextStyle(
          //             color: Theme.of(context).primaryColor,
          //           ),
          //         ),
          //       ),
          //       FlatButton(
          //         onPressed: () {
          //           alert_to_add_task();
          //         },
          //         child: Text(
          //           "E",
          //           style: TextStyle(
          //             color: Theme.of(context).primaryColor,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          //
          //  ),
          ),
    );
  }

  alert_to_edit_task(AdditionalTaskProvider additionalTaskProvider,
      AdditionalTask_model oldTask) {
    String oldName = oldTask.taskName;

    TextEditingController _controller = TextEditingController(text: oldName);

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
                          controller: _controller,
                          maxLength: 30,
                          decoration: InputDecoration(
                            labelText: "Task's Name",
                            hintStyle: TextStyle(
                                color: Theme.of(context).primaryColor),
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
                          onChanged: (value) {
                            setState(() {
                              oldName = value;
                              // _controller.text = value;
                            });
                          }),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              for (int index = 0; index < 7; index++)
                                Expanded(
                                  child: GestureDetector(
                                    child: oldIspressed[index]
                                        ? preesedButton(index)
                                        : unpressedButton(index),
                                    onTap: () {
                                      setState(() {
                                        oldIspressed[index] =
                                            !oldIspressed[index];
                                        if (oldIspressed[index]) {
                                          setState(() {
                                            dateTime = null;
                                          });
                                        }
                                        //print("pres is$ispressed");
                                      });
                                    },
                                  ),
                                ),
                            ],
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
                          Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.calendar_today_outlined,
                                    size: 17,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: Theme.of(context)
                                                  .primaryColor, // header background color
                                              secondary: Theme.of(context)
                                                  .primaryColor,
                                              onPrimary: Colors
                                                  .black, // header text color
                                              // onSurface: Colors.green, // body text color
                                            ),
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                primary: Theme.of(context)
                                                    .primaryColor, // button text color
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2040),
                                      initialDate:
                                          this.dateTime ?? DateTime.now(),
                                    ).then((date) {
                                      setState(() {
                                        this.dateTime = date;
                                        // String formattedDate = DateFormat('yyyy-MM-dd').format(_dateTime);
                                        // AllBirds.dateTime.value ="${_dateTime?.day}/${_dateTime?.month}/${_dateTime?.year}";
                                        if (dateTime != null) {
                                          oldIspressed = [
                                            false,
                                            false,
                                            false,
                                            false,
                                            false,
                                            false,
                                            false
                                          ];
                                        }
                                      });
                                    });
                                  },
                                ),
                                VerticalDivider(
                                    color: Colors.grey, thickness: 0.5),
                                // SizedBox(
                                //   width: width * 0.01,
                                // ),
                                dateTime == null
                                    ? Text(
                                        "- - -",
                                        textAlign: TextAlign.center,
                                      )
                                    : Text(
                                        "${dateTime?.day}/${dateTime?.month}/${dateTime?.year}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey[600]),
                                      )
                              ],
                            ),
                            //),
                          )
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
                          setState(() {
                            oldIspressed = [
                              false,
                              false,
                              false,
                              false,
                              false,
                              false,
                              false
                            ];
                            dateTime = null;
                          });
                          Navigator.of(context).pop();
                        },
                        textColor: Theme.of(context).primaryColor,
                        child: const Text('cancel'),
                      ),
                      new FlatButton(
                        onPressed: () {
                          final DateFormat formatter = DateFormat('yyyy-MM-dd');

                          oldName = _controller.text;
                          getTaskDays(oldIspressed);
                          String task = "";
                          task = joinFunc(selectedDays);

                          AdditionalTask_model newTask = AdditionalTask_model(
                            taskName: oldName,
                            id: oldTask.id,
                            roomName: oldTask.roomName,
                            cageName: oldTask.cageName,
                            cageId: oldTask.cageId,
                            roomId: oldTask.roomId,
                            isDone: oldTask.isDone,
                            appointment: dateTime == null
                                ? task
                                : formatter.format(dateTime!),
                          );
                          additionalTaskProvider.editTask(newTask);
                          Navigator.of(context).pop();
                          setState(() {
                            oldIspressed = [
                              false,
                              false,
                              false,
                              false,
                              false,
                              false,
                              false
                            ];
                            dateTime = null;
                          });
                          // cageProvider
                          //     .addCage(newCageName);
                          // setState(() {
                          //   newCageName = '';
                          // });
                        },
                        textColor: Theme.of(context).primaryColor,
                        child: const Text('Edit'),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  )
                ],
              ),
            ));
  }

  getTaskDays(List trueOrFalseList) {
    List taskDays = [];
    if (trueOrFalseList != [false, false, false, false, false, false, false]) {
      for (int i = 0; i < trueOrFalseList.length; i++) {
        if (trueOrFalseList[i]) {
          taskDays.add(daysWord[i]);
        } else {}
      }
    } else {
      taskDays = [];
    }
    setState(() {
      selectedDays = taskDays;
    });

    return taskDays;
  }

  joinFunc(List list) {
    if (list.isEmpty) {
      String string = "";
      return string;
    } else {
      final string = list.reduce((value, element) => value + ' ' + element);

      print("listis $string");
      return string;
    }
  }

  splitFunc(string) {
    if (string == "") {
      return [];
    }
    List<String> list = string.split(" ");
    print("split $list");
    return list;
  }

  getTrueFalseList(List task) {
    List<bool> result = [false, false, false, false, false, false, false];
    if (task.isEmpty) {
      return result;
    } else if (task.length == 7) {
      return [true, true, true, true, true, true, true];
    } else {
      for (int i = 0; i < task.length; i++) {
        var index = daysWord.indexWhere((element) => element == task[i]);
        result[index] = true;
      }
      print("result$result");
      return result;
    }
  }

  preesedButton(index) {
    return Padding(
      padding: EdgeInsets.all(1),
      child: Container(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            days[index],
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor,
          ),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
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
      ),
    );
  }

  // preesedButton(index) {
  //   return Padding(
  //     padding: EdgeInsets.all(1),
  //     child: Container(
  //       child: Container(
  //         padding: EdgeInsets.all(10),
  //         child: Text(
  //           days[index],
  //           style: TextStyle(
  //               color: Theme.of(context).primaryColor,
  //               fontWeight: FontWeight.w700),
  //         ),
  //         decoration: BoxDecoration(
  //             shape: BoxShape.circle,
  //             color: Colors.grey[300],
  //             boxShadow: [
  //               BoxShadow(
  //                   color: Colors.white,
  //                   offset: Offset(2.0, 2.0),
  //                   blurRadius: 7.0,
  //                   spreadRadius: .4),
  //               BoxShadow(
  //                   color: Colors.grey.shade500,
  //                   offset: Offset(-2.0, -2.0),
  //                   blurRadius: 15.0,
  //                   spreadRadius: .4),
  //             ],
  //             gradient: LinearGradient(
  //                 begin: Alignment.topLeft,
  //                 end: Alignment.bottomRight,
  //                 colors: [
  //                   Colors.grey.shade600,
  //                   Colors.grey.shade500,
  //                   Colors.grey.shade400,
  //                   Colors.grey.shade200,
  //                 ],
  //                 stops: [
  //                   0,
  //                   0.1,
  //                   0.3,
  //                   1
  //                 ])),
  //       ),
  //       decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           color: Colors.grey[200],
  //           boxShadow: [
  //             BoxShadow(
  //                 color: Colors.grey.shade500,
  //                 offset: Offset(2.0, 2.0),
  //                 blurRadius: 15.0,
  //                 spreadRadius: .4),
  //             BoxShadow(
  //                 color: Colors.white,
  //                 offset: Offset(-2.0, -2.0),
  //                 blurRadius: 15.0,
  //                 spreadRadius: .4),
  //           ],
  //           gradient: LinearGradient(
  //               begin: Alignment.topLeft,
  //               end: Alignment.bottomRight,
  //               colors: [
  //                 Colors.grey.shade200,
  //                 Colors.grey.shade300,
  //                 Colors.grey.shade400,
  //                 Colors.grey.shade500,
  //               ],
  //               stops: [
  //                 0.1,
  //                 0.3,
  //                 0.8,
  //                 1
  //               ])),
  //     ),
  //   );
  // }
  //
  // unpressedButton(index) {
  //   return Padding(
  //     padding: const EdgeInsets.all(1),
  //     child: Container(
  //       padding: EdgeInsets.all(10),
  //       child: Text(
  //         days[index],
  //         style: TextStyle(color: Theme.of(context).primaryColor),
  //       ),
  //       decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           color: Colors.grey[300],
  //           border: (Border.all(color: Theme.of(context).primaryColor)),
  //           boxShadow: [
  //             BoxShadow(
  //                 color: Colors.grey.shade600,
  //                 offset: Offset(2.0, 2.0),
  //                 blurRadius: 7.0,
  //                 spreadRadius: .4),
  //             BoxShadow(
  //                 color: Colors.white,
  //                 offset: Offset(-2.0, -2.0),
  //                 blurRadius: 7.0,
  //                 spreadRadius: .4),
  //           ],
  //           gradient: LinearGradient(
  //               begin: Alignment.topLeft,
  //               end: Alignment.bottomRight,
  //               colors: [
  //                 Colors.grey.shade200,
  //                 Colors.grey.shade300,
  //                 Colors.grey.shade400,
  //                 Colors.grey.shade500,
  //               ],
  //               stops: [
  //                 0.1,
  //                 0.3,
  //                 0.8,
  //                 1
  //               ])),
  //     ),
  //   );
  // }

}
