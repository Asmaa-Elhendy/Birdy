import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:birdy_app/controller/db/cages_database.dart';
import 'package:birdy_app/controller/providers/additional_task_provider.dart';
import 'package:birdy_app/controller/providers/bird_provider.dart';
import 'package:birdy_app/controller/providers/cage_provider.dart';
import 'package:birdy_app/controller/providers/rooms_provider.dart';
import 'package:birdy_app/controller/room_db_connection.dart';
import 'package:birdy_app/model/additional_task_model.dart';
import 'package:birdy_app/model/cage_model.dart';
import 'package:birdy_app/model/rooms_model.dart';
import 'package:birdy_app/view/screens/bird.dart';
import 'package:birdy_app/view/widgets/animated_page_route.dart';
import 'package:birdy_app/view/widgets/card_bird.dart';
import 'dashboard.dart';
import 'edit_additional_task.dart';
import 'package:intl/intl.dart';


class AllBirds extends StatefulWidget {
  static ValueNotifier<String> dateTime = ValueNotifier("");


  bool exist_bar = true;
  Cage? cage;
  Rooms_Model? room;

  AllBirds({required this.exist_bar, this.cage, this.room});

  @override
  _AllBirdsState createState() => _AllBirdsState();
}

class _AllBirdsState extends State<AllBirds> {

  int selected_index=0;
  var items = [
    'Add',
    'Edit',
  ];
  var selectValue;
  List<bool> ispressed = [false, false, false, false, false, false, false];
  List days = ["M", "T", "W", "T", "F", "S", "S"];
  List daysWord =["Monday", "Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];
  DateTime? _dateTime;
  List selectedDays=[];
  String appointment ="";

  TextEditingController additionalTaskController = TextEditingController();




  static List<AdditionalTask_model> additional_task=[];
  @override
  void initState() {
    BirdProvider birdsProvider = Provider.of<BirdProvider>(context,listen: false);
    if(widget.exist_bar){
      birdsProvider.readBirdByCage(widget.cage?.id);
    }else{
      birdsProvider.readAllBirds();
    }
    super.initState();
  }

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
    BirdProvider birdsProvider = Provider.of<BirdProvider>(context);
      AdditionalTaskProvider additionalTaskProvider = Provider.of<AdditionalTaskProvider>(context);

    return Scaffold(
     floatingActionButton:  widget.exist_bar?FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushReplacement(createRoute(Add_bird(cage_room_detected: widget.exist_bar,cage: widget.cage!,room: widget.room!)));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xfff79281),
        tooltip: 'add bird',
      ):FloatingActionButton(
       onPressed: (){
         Navigator.of(context).pushReplacement(createRoute(Add_bird(cage_room_detected: false,)));
       },
       child: Icon(Icons.add),
       backgroundColor: Color(0xfff79281),
       tooltip: 'add bird',
     ),
      body: Container(
        height: height,
        padding: EdgeInsets.only(top: height*0.07),

        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Image.asset("assets/images/cage-birds.png", width: 60,),
              ),
             widget.exist_bar? Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.07,vertical: height*0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width,
                      height: height*0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xfff79281).withOpacity(0.3),
                      ),
                      child: Center(child: Text("Room:${widget.room!.roomName}  &  Cage:${widget.cage!.cageName}",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 16
                        ),
                      )),
                    ),
                    Row(
                      children: [
                        Text("Additional Tasks",style: TextStyle(color: Colors.grey[600],fontSize: 16)),
                        SizedBox(width: width*0.02,),
                        DropdownButton(
                          //isExpanded: true,
                          // hint:Text( "Additional Tasks"),
                          style: TextStyle(color: Colors.grey[600],

                          ),

                          // underline: Container(
                          //   height: 2,
                          //   color: Theme.of(context).primaryColor,
                          // ),
                          focusColor: Theme.of(context).primaryColor,

                          // Initial Value
                          value: selectValue,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: ( newValue) {
                            setState(() {
                              selectValue = newValue!;
                            });
                            selectValue=="Add"?alert_to_add_task(additionalTaskProvider):selectValue=="Edit"? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditAdditionalTask(widget.cage!)),
                            ):null;
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ):Container(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.07,vertical: height*0.022),
                child: SizedBox(height:widget.exist_bar? height*.58:height*.67,child:

                  ListView.builder(
                    itemCount:widget.exist_bar? birdsProvider.needBirds.length: birdsProvider.birds.length,
                    itemBuilder:(BuildContext context,int index) {
                      return Card_bird(bird: widget.exist_bar? birdsProvider.needBirds[index]: birdsProvider.birds[index],birdsProvider: birdsProvider,exist_bar: widget.exist_bar,cage: widget.cage,room: widget.room,);
                    },


                  ),

                )

              )

            ],
          ),
        ),
      ),

    );
  }
  _onTap(int index) {
    CageProvider  _cageProvider = Provider.of<CageProvider>(context, listen: false);
    Rooms_Provider _romsProv=  Provider. of<Rooms_Provider>(context,listen: false);
    BirdProvider  _birdsprov =     Provider. of<BirdProvider>(context,listen: false);
    setState(() {
      selected_index=index;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard(selected_index: selected_index,))).then((value) {
       // setState(() {
          _cageProvider.dispose();
          _romsProv.dispose();
          _birdsprov.dispose();
          CagesDatabase.instance.close();
          DatabaseConnection().close();
        // Provider. of<CageProvider>(context,listen: false). dispose();
          // Provider. of<Rooms_Provider>(context,listen: false). dispose();
          // Provider. of<BirdProvider>(context,listen: false). dispose();

        //});

      });
    });
  }

  alert_to_add_task(AdditionalTaskProvider additionalTaskProvider) {

    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(

          builder: (context,setState)=>AlertDialog(
            title: Text("Add New Additional Task"),
            content: SingleChildScrollView(
              child: Column(

                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: additionalTaskController,
                      maxLength: 30,


                      decoration: InputDecoration(
                        labelText: "Task's Name",
                        hintStyle: TextStyle(
                          color: Theme.of(context).primaryColor
                        ),

                        enabledBorder:
                        const OutlineInputBorder(
                            borderSide:
                            const BorderSide(
                                color: Color(
                                    0xfff79281),
                                width: 0.3),
                            borderRadius:
                            BorderRadius.all(
                                Radius
                                    .circular(
                                    25))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(
                                color: Color(
                                    0xfff79281),
                                width: 0.3),
                            borderRadius:
                            BorderRadius.all(
                                Radius.circular(
                                    25))),
                      ),
                      ),
                  Text(
                    " choose Appointment",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),

                      Row(
                      children: [
                        for (int index = 0;
                        index < 7;
                        index++)
                          Expanded(
                            child: GestureDetector(
                              child: ispressed[index]
                                  ? preesedButton(index)
                                  :unpressedButton(index),
                              onTap: () {
                                setState(() {
                                  ispressed[index] =
                                  !ispressed[index];
                                  //print("pres is$ispressed");

                                });
                                if(ispressed[index]){
                                  setState(() {
                                    _dateTime =null;
                                    print("date time after $_dateTime");
                                  });


                                }

                              },


                              // onTapDown: (_) {
                              //   pressing = true;
                              // },
                              // onTapUp: (_) {
                              //   pressing = false;
                              // }
                            ),
                          ),

                      ],
                    ),
                 // ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.027,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("OR: ",
                      ),
                      // DatePicker()
                     // datePicker()
              Container(

                height: MediaQuery.of(context).size.height*0.06,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.calendar_today_outlined,
                        size: 17,
                        color: Theme.of(context).primaryColor,
                      ) ,
                      onPressed: (){
                        showDatePicker(
                          context:context,
                          builder: ( context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary:Theme.of(context).primaryColor, // header background color
                                  secondary: Theme.of(context).primaryColor,
                                  onPrimary: Colors.black, // header text color
                                  // onSurface: Colors.green, // body text color
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    primary: Theme.of(context).primaryColor, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2040),
                          initialDate: this._dateTime?? DateTime.now() ,


                        ).then((date) {

                          setState(() {
                            this. _dateTime = date;
                            // String formattedDate = DateFormat('yyyy-MM-dd').format(_dateTime);
                            AllBirds.dateTime.value ="${_dateTime?.day}/${_dateTime?.month}/${_dateTime?.year}";
                            if(_dateTime!=null){
                              ispressed = [false, false, false, false, false, false, false];
                            }
                          });
                        }
                        );

                      },
                    ),
                    VerticalDivider(
                        color: Colors.grey,
                        thickness: 0.5
                    ),
                    // SizedBox(
                    //   width: width * 0.01,
                    // ),
                     _dateTime==null?Text("- - -",textAlign: TextAlign.center,):Text("${_dateTime?.day}/${_dateTime?.month}/${_dateTime?.year}",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[600]
                      ),
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
                      Navigator.of(context).pop();
                    },
                    textColor: Theme.of(context)
                        .primaryColor,
                    child: const Text('cancel'),
                  ),
                  new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      getTaskDays(ispressed);
                      if(selectedDays.isNotEmpty){
                        setState(() {
                          appointment = joinFunc(selectedDays);
                        });

                      }else{
                        final DateFormat formatter = DateFormat('yyyy-MM-dd');
                        setState(() {
                          appointment = formatter.format(_dateTime!);
                          print("appontment in add is$appointment" );

                          //appointment = "${_dateTime?.day}/${_dateTime?.month}/${_dateTime?.year}";
                        });
                      }
                      print("appointment is $appointment");
                      additionalTaskProvider.addAdditionalTask(
                          additionalTaskController.text,
                          widget.cage!.id!,
                          widget.room!.id,
                          widget.cage!.cageName,
                          widget.room!.roomName,
                          appointment,
                          false);
                      setState((){
                        _dateTime=null;
                        ispressed=[false, false, false, false, false, false, false];
                        additionalTaskController.clear();
                      });


                    },
                    textColor: Theme.of(context)
                        .primaryColor,
                    child: const Text('Add'),
                  )
                ],
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
              )
            ],
          ),
        ));

  }
  // preesedButton(index) {
  //   return Padding(
  //     padding: EdgeInsets.all(1),
  //     child: Container(
  //       child: Container(
  //         padding: EdgeInsets.all(10),
  //         child: Text(
  //           days[index],
  //           style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w700),
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
  //                 ]
  //             )
  //         ),
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
  //               ]
  //           )
  //       ),
  //
  //     ),
  //   );
  // }
  preesedButton(index) {
    return Padding(
      padding: EdgeInsets.all(1),
      child: Container(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            days[index],
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
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
  unpressedButton(index){
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Container(

        padding: EdgeInsets.all(10),
        child: Text(days[index],style: TextStyle(color: Theme.of(context).primaryColor),),

      ),
    );
  }

  getTaskDays(List trueOrFalseList){
    List taskDays = [];
    if(trueOrFalseList != [false,false,false,false,false,false,false]) {
      for (int i = 0; i < trueOrFalseList.length; i++) {
        if (trueOrFalseList[i]) {
          taskDays.add(daysWord[i]);
        } else {

        }
      }
    }else{
      taskDays = [];
    }
    setState(() {
      selectedDays = taskDays;
    });


    return taskDays;
  }

  joinFunc(List list){
    if(list.isEmpty){
      String string = "";
      return string;
    }
    else{
      final string = list.reduce((value, element) => value + ' ' + element);

      return string;
    }

  }


// unpressedButton(index){
  //   return Padding(
  //     padding: const EdgeInsets.all(1),
  //     child: Container(
  //
  //       padding: EdgeInsets.all(10),
  //       child: Text(days[index],style: TextStyle(color: Theme.of(context).primaryColor),),
  //       decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           color: Colors.grey[300],
  //           //border: (Border.all(color: Theme.of(context).primaryColor)),
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

// Widget datePicker(){
//   var width = MediaQuery.of(context).size.width;
//   var height = MediaQuery.of(context).size.height;
//    return
//   // StatefulBuilder(
//   //   builder: (context, setState) =>
//      Container(
//
//       height: height*0.06,
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.grey,
//           width: 0.5,
//         ),
//       ),
//       child: Row(
//         children: [
//           IconButton(
//             icon: Icon(Icons.calendar_today_outlined,
//               size: 17,
//               color: Theme.of(context).primaryColor,
//             ) ,
//             onPressed: (){
//               showDatePicker(
//                 context:context,
//                 builder: ( context, child) {
//                   return Theme(
//                     data: Theme.of(context).copyWith(
//                       colorScheme: ColorScheme.light(
//                         primary:Theme.of(context).primaryColor, // header background color
//                         secondary: Theme.of(context).primaryColor,
//                         onPrimary: Colors.black, // header text color
//                         // onSurface: Colors.green, // body text color
//                       ),
//                       textButtonTheme: TextButtonThemeData(
//                         style: TextButton.styleFrom(
//                           primary: Theme.of(context).primaryColor, // button text color
//                         ),
//                       ),
//                     ),
//                     child: child!,
//                   );
//                 },
//                 firstDate: DateTime(2000),
//                 lastDate: DateTime(2040),
//                 initialDate: this._dateTime?? DateTime.now() ,
//
//
//               ).then((date) {
//
//                 setState(() {
//                  this. _dateTime = date;
//                   // String formattedDate = DateFormat('yyyy-MM-dd').format(_dateTime);
//                   AllBirds.dateTime.value ="${_dateTime?.day}/${_dateTime?.month}/${_dateTime?.year}";
//                   if(_dateTime!=null){
//                     ispressed = [false, false, false, false, false, false, false];
//                   }
//                 });
//               }
//               );
//
//             },
//           ),
//           VerticalDivider(
//               color: Colors.grey,
//               thickness: 0.5
//           ),
//           // SizedBox(
//           //   width: width * 0.01,
//           // ),
//          this. _dateTime==null?Text("- - -",textAlign: TextAlign.center,):Text("${_dateTime?.day}/${_dateTime?.month}/${_dateTime?.year}",
//             style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.normal,
//                 color: Colors.grey[600]
//             ),
//           )
//         ],
//       ),
//     //),
//   );
//
// }
}