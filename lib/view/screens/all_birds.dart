import 'package:birdy_app/controller/db/cages_database.dart';
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
import 'package:birdy_app/view/widgets/datepicker_calender.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'daily_tasks.dart';
import 'dashboard.dart';
import 'edit_additional_task.dart';

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

  static List<AdditionalTask_model> additional_task=[
    AdditionalTask_model(
        id: "1",
        cage: "1",
        room: "2",
        taskName: "put treatment",
      appointment: "12/3"
    ),
    AdditionalTask_model(
        id: "2",
        cage: "2",
        room: "3",
        taskName: "put treatment",
      appointment: "12/4",

    ),
    AdditionalTask_model(
        id: "7",
        cage: "4",
        room: "Office Room",
        taskName: "put treatment",
      appointment: "12/5"
    ),
  ];
  String appointment="";
  final newTaskName = TextEditingController();
 // _cageProvider = Provider. of<CageProvider>(context,listen: false);

  // @override
  // void afterFirstLayout(BuildContext context) {
  //   CageProvider  _cageProvider = Provider.of<CageProvider>(context, listen: false);
  //   Rooms_Provider _romsProv=  Provider. of<Rooms_Provider>(context,listen: false);
  //   BirdProvider  _birdsprov =     Provider. of<BirdProvider>(context,listen: false);
  //
  //
  // }


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

  // @override
  // void dispose() {
  //   CagesDatabase.instance.close();
  //
  //   super.dispose();
  // }
  // @override
  // void dispose() {
  //   _cageProvider.
  //   // Provider. of<CageProvider>(context,listen: false). cl();
  //   // Provider. of<Rooms_Provider>(context,listen: false). dispose();
  //   // Provider. of<BirdProvider>(context,listen: false). dispose();
  //     super.dispose();
  // }


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





    return Scaffold(
    // bottomNavigationBar: BottomNavigationBar(
    //     selectedItemColor:Color(0xfff79281) ,
    // currentIndex: selected_index,
    // onTap: _onTap,
    // items: <BottomNavigationBarItem> [
    // BottomNavigationBarItem(
    // icon: Icon(Icons.home,),
    // label: 'Home',
    //
    // ),
    //   BottomNavigationBarItem(
    //     icon: Icon(Icons.event),
    //     label: 'Daily tasks',
    //   ),
    // BottomNavigationBarItem(
    // icon: Icon(Icons.account_circle_rounded,),
    // label: 'profile',
    // ),
    // ],
    //
    // ),
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
                    DropdownButton(
                      //isExpanded: true,
                      hint:Text( "Additional Tasks"),
                      style: TextStyle(color: Colors.grey[600],
                      ),
                      underline: Container(
                        height: 2,
                        color: Theme.of(context).primaryColor,
                      ),
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
                        selectValue=="Add"?alert_to_add_task():selectValue=="Edit"? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditAdditionalTask(tasks: additional_task,)),
                        ):null;
                      },
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
  // _onTap(int index) {
  //   CageProvider  _cageProvider = Provider.of<CageProvider>(context, listen: false);
  //   Rooms_Provider _romsProv=  Provider. of<Rooms_Provider>(context,listen: false);
  //   BirdProvider  _birdsprov =     Provider. of<BirdProvider>(context,listen: false);
  //   setState(() {
  //     selected_index=index;
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard(selected_index: selected_index,))).then((value) {
  //      // setState(() {
  //         _cageProvider.dispose();
  //         _romsProv.dispose();
  //         _birdsprov.dispose();
  //         CagesDatabase.instance.close();
  //       // Provider. of<CageProvider>(context,listen: false). dispose();
  //         // Provider. of<Rooms_Provider>(context,listen: false). dispose();
  //         // Provider. of<BirdProvider>(context,listen: false). dispose();
  //
  //       //});
  //
  //     });
  //   });
  // }

  alert_to_add_task() {
    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context,setState)=>AlertDialog(
            title: Text("Add New Additional Task"),
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

                            // child: Container(
                            //   decoration: BoxDecoration(
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: ispressed[index]?Colors.black38:Colors.transparent,
                            //         spreadRadius: 2,
                            //         blurRadius: 2,
                            //         offset: Offset(4, 3), // changes position of shadow
                            //       ),
                            //     ],
                            //     shape: BoxShape.circle,
                            //     border: Border.all(
                            //         width: !ispressed[index]?2:1,
                            //         color: Color(
                            //             0xfff79281)),
                            //     color:ispressed[index]
                            //         ? Color(0xfff79281)
                            //         : Colors.white,
                            //   ),
                            //
                            //   child: Center(
                            //     child: Text(
                            //       days[index],
                            //       style: TextStyle(
                            //         color: !ispressed[
                            //         index]
                            //             ? Color(
                            //             0xfff79281)
                            //             : Colors.white,
                            //       ),
                            //       //textAlign: TextAlign.center,
                            //     ),
                            //   ),
                            //   width: 35,
                            //   height: 35,
                            //   //padding: EdgeInsets.only(top: height*0.002),
                            // ),

                            onTap: () {
                              setState(() {
                                ispressed[index] =
                                !ispressed[index];
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
                        ),

                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.027,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("OR: ",
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
                    textColor: Theme.of(context)
                        .primaryColor,
                    child: const Text('cancel'),
                  ),
                  new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      List time=[];
                      String ?calenderData;

                      setState(() {
                        // ValueListenableBuilder(
                        //   valueListenable: AllBirds.dateTime,
                        // )
                        for(int i =0; i<7;i++){
                          if(ispressed[i]==true){
                            time.add(days[i]);
                          }
                          // if( AllBirds.dateTime.value!=""){
                          //   time.add( AllBirds.dateTime.value);
                          // }
                        }
                        if( AllBirds.dateTime.value!=""){
                          time.add( "${AllBirds.dateTime.value}");
                          //calenderData =  AllBirds.dateTime.value.toString();
                        }
                        String timeConcatenate = time.join(',');

                        String timeData = AllBirds.dateTime.value.toString();
                        additional_task.add(AdditionalTask_model(id: "7", taskName: newTaskName.text, room: "office room", cage: "cage1",appointment: "${timeConcatenate}"));
                        DailyTasks.additionalTasks.value=additional_task;
                        print("listis${additional_task.toList()}");
                        print("timr here${ AllBirds.dateTime.value}");
                        print("time calender$timeConcatenate");
                        //print("pres is$ispressed");
                      });
                      // cageProvider
                      //     .addCage(newCageName);
                      // setState(() {
                      //   newCageName = '';
                      // });
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
  preesedButton(index) {
    return Padding(
      padding: EdgeInsets.all(1),
      child: Container(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            days[index],
            style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w700),
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
                  ]
              )
          ),
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
                ]
            )
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
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
            //border: (Border.all(color: Theme.of(context).primaryColor)),
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