import 'package:birdy_app/controller/providers/bird_provider.dart';
import 'package:birdy_app/controller/providers/cage_provider.dart';
import 'package:birdy_app/controller/providers/rooms_provider.dart';
import 'package:birdy_app/model/cage_model.dart';
import 'package:birdy_app/model/rooms_model.dart';
import 'package:birdy_app/view/screens/all_birds.dart';
import 'package:birdy_app/view/widgets/animated_page_route.dart';
import 'package:birdy_app/view/widgets/snack_bar_delete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard.dart';

class Cages extends StatefulWidget {
  static const cageid = 'id';
  Rooms_Model room;
  Cages({required this.room}); //*****

  @override
  _CagesState createState() => _CagesState();
}

class _CagesState extends State<Cages> {
  List<bool> ispressedCleaning = [true, true, true, true, true, true, true];
  List<bool> ispressedFeeding = [true, true, true, true, true, true, true];
  List<bool> ispressedWatering = [true, true, true, true, true, true, true];
  List<bool> oldIspressedCleaning = [false, false, false, false, false, false, false];
  List<bool> oldIspressedFeeding = [false, false, false, false, false, false, false];
  List<bool> oldIspressedWatering =[false, false, false, false, false, false, false];

  List days = ["M", "T", "W", "T", "F", "S", "S"];
  List daysWord =["Monday", "Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];
  List cleaningDaysSelected = [];
  List feedingDaysSelected = [];
  List wateringDaysSelected = [];

  late String newName = '';
  late String newCageName = '';
  var selectedUser;
  late String selectedRoomName;
  int selected_index = 0;
  @override
  void initState() {
    CageProvider cages_provider = Provider.of<CageProvider>(context,listen: false);
    cages_provider.getRoomCage(widget.room.id);


    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     CageProvider cages_provider = Provider.of<CageProvider>(context);
     cages_provider.getRoomCage(widget.room.id);


      TextEditingController cageNameController = TextEditingController();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Color _colorContainer = Colors.blue;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * .05,
              ),
              Center(
                child: Container(
                  width: width * .85,
                  height: height * .17,
                  padding: EdgeInsets.all(height * .03),
                  decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(.1),
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/manage-cages.png",
                          width: 60,
                        ),
                        SizedBox(
                          width: width * .06,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hello Asmaa',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('manage your cages'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .04,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Room: ${widget.room.roomName}",
                    style: TextStyle(
                        color: Color(0xfff79281),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )

                  ,
                  SizedBox(
                    height: height * .05,
                    child: Builder(builder: (context) {
                      return ElevatedButton(
                        child: Text(
                          "ADD Cage",
                          style: TextStyle(
                            color: Color(0xfff79281),
                          ),
                        ),
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.grey), //********
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty
                                .all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(
                                          color: Color(0xfff79281),
                                        )))),
                        onPressed: () {
                          setState(() {
                            ispressedCleaning = [true, true, true, true, true, true, true];
                            ispressedFeeding = [true, true, true, true, true, true, true];
                            ispressedWatering = [true, true, true, true, true, true, true];
                          });

                          showDialog(
                              context: context,
                              builder: (context) => StatefulBuilder(
                                    builder: (context, setState) => AlertDialog(
                                      // insetPadding: EdgeInsets.all(10),
                                      title: Text('Add New Cage'),
                                      content: GestureDetector(
                                        onTap: () {

                                          FocusScopeNode currentFocus;
                                          currentFocus = FocusScope.of(context);
                                          if (!currentFocus.hasPrimaryFocus) {

                                            currentFocus.unfocus();

                                          }

                                        },
                                        child: SingleChildScrollView(
                                          child: Container(
                                            height: height * .4,
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  TextField(
                                                    controller: cageNameController,



                                                      decoration:
                                                          InputDecoration(
                                              hintText: "Enter Your Cage Name",
                                                        hintStyle: TextStyle(
                                                          color: Colors.black45
                                                        ),
                                                        enabledBorder: const OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Color(
                                                                        0xfff79281),
                                                                    width: 0.3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            25))),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Color(
                                                                        0xfff79281),
                                                                    width: 0.3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            25))),
                                                      ),

                                                      ),

                                                  daysContainer("Cleaning",
                                                      ispressedCleaning),
                                                  daysContainer("Feeding",
                                                      ispressedFeeding),

                                                  daysContainer("Watering",
                                                      ispressedWatering),
                                                ]),
                                          ),
                                        ),
                                      ),

                                      actions: <Widget>[
                                        Row(
                                          children: [
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                setState((){
                                                  cageNameController.clear();
                                                });
                                              },
                                              textColor: Theme.of(context)
                                                  .primaryColor,
                                              child: const Text('cancel'),
                                            ),
                                            new FlatButton(
                                               onPressed: () async{
                                                 getTaskDays(ispressedFeeding,"feed");
                                                 getTaskDays(ispressedCleaning,"clean");
                                                  getTaskDays(ispressedWatering,"water");
                                                  String water="";
                                                  String feed = "";
                                                  String clean = "";
                                                 water =  joinFunc(wateringDaysSelected);
                                                 feed =  joinFunc(feedingDaysSelected);
                                                 clean =  joinFunc(cleaningDaysSelected);
                                                 print("feed is $feed,water is $water,clean is $clean");

                                                 await cages_provider.addCage(cageNameController.text, widget.room.id, 0, clean, feed, water,widget.room.roomName);

                                                 setState((){

                                                   cageNameController.clear();
                                                 });

                                                 Navigator.of(context).pop(context);

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
                        },
                      );
                    }),
                  )
                ],
              ),
              SizedBox(
                height: height * .02,
              ),
              SizedBox(
                height: height * .55,
                child: cages_provider.need.isEmpty?Center(child: Text("no cages")):ListView.builder(
                itemCount: cages_provider.need.length,
                    itemBuilder: (context, index) {

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(createRoute(AllBirds(
                            exist_bar: true,
                            cage:  cages_provider.need[index] ,
                            room: widget.room,
                          )));
                        //       .then((value) => setState(() {
                        //     //Provider. of<CageProvider>(context,listen: false). dispose();
                        //
                        //   }));
                         },
                        child: customListtile(
                            width,
                            height,
                            // cageProvider.cages[index].cageName,
                            cages_provider.need[index].cageName,
                            context,
                            cages_provider,
                            index),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xfff79281),
        currentIndex: selected_index,
        onTap: _onTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Daily tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_rounded,
            ),
            label: 'profile',
          ),
        ],
      ),
    );
  }

  _onTap(int index) {
    setState(() {
      selected_index=index;
      if(selected_index==1){
        CageProvider cageProvider =Provider.of<CageProvider>(context,listen: false);
        cageProvider.getcagesDatabase();
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard(selected_index: selected_index,)));
    });
  }

  Widget customListtile(width, hight, String name, context,
      CageProvider cageProvider, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.02 * hight),
      child: Row(
        children: [
          Expanded(
            child: Container(
                margin: EdgeInsets.only(right: width * .04),
                padding: EdgeInsets.symmetric(horizontal: width * .05),
                height: hight * .07,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text('${name}')),
                    Row(
                      children: [
                     InkWell(
                          onTap: ()async {
                            Cage cageToEdit = await cageProvider.getCage(cageProvider.need[index].id!);

                            String oldFeed = cageToEdit.feedingDays;
                            String oldClean = cageToEdit.cleaningDays;
                            String oldWater = cageToEdit.wateringDays;
                            List  oldFeedList = splitFunc(oldFeed);
                            List oldCleanList = splitFunc(oldClean);
                            List oldWaterList = splitFunc(oldWater);
                            print("old$oldWaterList");
                            setState(() {
                              oldIspressedWatering = getTrueFalseList(oldWaterList);
                              oldIspressedFeeding = getTrueFalseList(oldFeedList);
                              oldIspressedCleaning = getTrueFalseList(oldCleanList);

                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialog(context, cageToEdit,  "edit cage",cageProvider)

                            );
                          },
                          child: Icon(
                            Icons.edit,
                            color: Color(0xfff79281),
                          ),
                        ),
                        SizedBox(
                          width: width * .03,
                        ),
                        cageProvider.need[index].birdNumbers>0?
                       GestureDetector(
                         onTap: (){
                           const snackBar = SnackBar(
                             content: Text('You Can not delete this cage, it contains birds'),
                           );
                           ScaffoldMessenger.of(context).showSnackBar(snackBar);
                         },
                         child: Icon(
                           Icons.delete_forever,
                           color: Colors.grey[350]
                         ),

                       )

                        :GestureDetector(
                          onTap: () {

                            ScaffoldMessenger.of(context)
                                .showSnackBar(Snack.SNackbarfun(context, ()
                            {
                              cageProvider.deleteCage(cageProvider.need[index].id!);
                            }));

                          },
                          child: Icon(
                            Icons.delete_forever,
                            color: Color(0xfff79281),
                          ),
                        )
                      ],
                    )
                  ],
                )),
          ),
          Image.asset("assets/images/birds.png", scale: 1.7),
          Container(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 24,
                child: Text(
                  //
                  cageProvider.need[index].birdNumbers.toString(),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  border: new Border.all(
                    color: Color(0xfff79281),
                  )))
        ],
      ),
    );
  }

  Widget _buildPopupDialog(
      BuildContext context,Cage cageToEdit,String title,CageProvider cageProvider
      )

   {
     int? id =cageToEdit.id;
     String oldName = cageToEdit.cageName;
     int roomId= cageToEdit.room_id;
     int birdNum = cageToEdit.birdNumbers;
     TextEditingController _controller = TextEditingController(text: oldName);

    return new AlertDialog(
      title: Text(title),
      content: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus;
          currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height*.4,
            child: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: _controller,     //name = .text
                      decoration: InputDecoration(

                        enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xfff79281), width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(25))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xfff79281), width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(25))),
                      ),
                      onChanged: (value) {
                        setState(() {
                          oldName = value;
                         // _controller.text = value;
                        });
                      }
                      ),
                   SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                   daysContainer("Cleaning", oldIspressedCleaning),
                    daysContainer("Feeding", oldIspressedFeeding),
                    daysContainer("Watering", oldIspressedWatering)



                ]),
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          children: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(context);
              },
              textColor: Theme.of(context).primaryColor,
              child: const Text('close'),
            ),
            new FlatButton(
              onPressed: (){
                oldName = _controller.text;
                getTaskDays(oldIspressedFeeding,"feed");
                getTaskDays(oldIspressedCleaning,"clean");
                getTaskDays(oldIspressedWatering,"water");
                String water="";
                String feed = "";
                String clean = "";
                water =  joinFunc(wateringDaysSelected);
                feed =  joinFunc(feedingDaysSelected);
                clean =  joinFunc(cleaningDaysSelected);
                print("feed is $feed,water is $water,clean is $clean");
                Cage newCage = Cage(cageName: oldName, cleaningDays: clean,
                    feedingDays: feed,
                    wateringDays: water,
                    room_id: roomId,birdNumbers: birdNum,
                    id: id,roomName: widget.room.roomName);
                cageProvider.editCage(newCage);
                Navigator.of(context).pop(context);

              },
              textColor: Theme.of(context).primaryColor,
              child: const Text('ok'),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        )
      ],
    );
  }

  daysContainer(String title, List list) {
    return StatefulBuilder(
      builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.001,
          ),
          Row(
            children: [
              for (int index = 0; index < 7; index++)

                Expanded(
                  child: GestureDetector(

                    child:list[index]
                        ? preesedButton(index)
                        :unpressedButton(index),
                    onTap: () {
                      setState(() {
                        list[index] = !list[index];
                        //print("pres is$ispressed");
                        print("in gesture $ispressedWatering");
                      });
                    },

                  ),

                ),

            ],
          ),
          // Row(
          //   children: [
          //     for (int index = 0; index < 7; index++)
          //       Container(
          //         decoration: BoxDecoration(
          //
          //           shape: BoxShape.circle,
          //
          //           border: Border.all(color: Theme.of(context).primaryColor),
          //           color: list[index] ? Color(0xfff79281) : Colors.white,
          //         ),
          //
          //         child: RaisedButton(
          //           shape:RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(18.0),
          //               side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1)
          //               )
          //           ),
          //
          //
          //           child: Text(
          //             days[index],
          //             style: TextStyle(
          //               color:
          //                   !list[index] ? Color(0xfff79281) : Colors.white,
          //             ),
          //             //textAlign: TextAlign.center,
          //           ),
          //           onPressed: (){
          //             setState(() {
          //               list[index] = !list[index];
          //               //print("pres is$ispressed");
          //             });
          //           },
          //         ),
          //         width: 35,
          //         height: 35,
          //         //padding: EdgeInsets.only(top: height*0.002),
          //
          //       ),
          //
          //   ],
          // ),
          //SizedBox(height: MediaQuery.of(context).size.height*0.01,)
        ],
      ),
    );
  }

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

  getTaskDays(List trueOrFalseList,hint){
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
    if(hint == "water"){
      setState(() {
        wateringDaysSelected = taskDays;
      });
    }else if(hint=="feed"){
      feedingDaysSelected = taskDays;

    }else if(hint == "clean"){
      cleaningDaysSelected = taskDays;

    }
    print("water $wateringDaysSelected, feed $feedingDaysSelected, clean $cleaningDaysSelected");

    return taskDays;
  }

  joinFunc(List list){
    if(list.isEmpty){
      String string = "";
      return string;
    }
    else{
      final string = list.reduce((value, element) => value + ' ' + element);

      print("listis $string");
      return string;
    }

  }
  splitFunc(string){
    if(string == ""){
      return [];
    }
    List<String> list = string.split(" ");
    print("split $list");
    return list;

  }

  getTrueFalseList(List task){
    List<bool> result = [false,false,false,false,false,false,false];
    if(task.isEmpty){
      return result;
    } else if(task.length==7){
      return [true,true,true,true,true,true,true];
    }else{
      for(int i =0;i<task.length;i++){
        var index = daysWord.indexWhere((element) => element ==task[i]);
        result[index] = true;
      }
      print("result$result");
      return result;
    }


  }

  // preesedButton(index) {
  //   return Padding(
  //     padding: EdgeInsets.all(1),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         shape: BoxShape.circle,color: Theme.of(context).primaryColor,
  //
  //
  //       ),
  //       width: 30,
  //       height: 30,
  //
  //       child: Text(days[index],style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
  //       // child: Container(
  //       //   padding: EdgeInsets.all(10),
  //       //   child: Text(
  //       //     days[index],
  //       //     style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w700),
  //       //   ),
  //       //   decoration: BoxDecoration(
  //       //       shape: BoxShape.circle,
  //       //       color: Colors.grey[300],
  //       //       boxShadow: [
  //       //         BoxShadow(
  //       //             color: Colors.white,
  //       //             offset: Offset(2.0, 2.0),
  //       //             blurRadius: 7.0,
  //       //             spreadRadius: .4),
  //       //         BoxShadow(
  //       //             color: Colors.grey.shade500,
  //       //             offset: Offset(-2.0, -2.0),
  //       //             blurRadius: 15.0,
  //       //             spreadRadius: .4),
  //       //       ],
  //       //       gradient: LinearGradient(
  //       //           begin: Alignment.topLeft,
  //       //           end: Alignment.bottomRight,
  //       //           colors: [
  //       //             Colors.grey.shade600,
  //       //             Colors.grey.shade500,
  //       //             Colors.grey.shade400,
  //       //             Colors.grey.shade200,
  //       //           ],
  //       //           stops: [
  //       //             0,
  //       //             0.1,
  //       //             0.3,
  //       //             1
  //       //           ]
  //       //       )
  //       //   ),
  //       // ),
  //       // decoration: BoxDecoration(
  //       //     shape: BoxShape.circle,
  //       //     color: Colors.grey[200],
  //       //     boxShadow: [
  //       //       BoxShadow(
  //       //           color: Colors.grey.shade500,
  //       //           offset: Offset(2.0, 2.0),
  //       //           blurRadius: 15.0,
  //       //           spreadRadius: .4),
  //       //       BoxShadow(
  //       //           color: Colors.white,
  //       //           offset: Offset(-2.0, -2.0),
  //       //           blurRadius: 15.0,
  //       //           spreadRadius: .4),
  //       //     ],
  //       //     gradient: LinearGradient(
  //       //         begin: Alignment.topLeft,
  //       //         end: Alignment.bottomRight,
  //       //         colors: [
  //       //           Colors.grey.shade200,
  //       //           Colors.grey.shade300,
  //       //           Colors.grey.shade400,
  //       //           Colors.grey.shade500,
  //       //         ],
  //       //         stops: [
  //       //           0.1,
  //       //           0.3,
  //       //           0.8,
  //       //           1
  //       //         ]
  //       //     )
  //       // ),
  //
  //     ),
  //   );
  // }
  // unpressedButton(index){
  //   return Padding(
  //     padding: const EdgeInsets.all(1),
  //     child: Container(
  //       child: Text(days[index],style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w700),),
  //
  //
  //       padding: EdgeInsets.all(10),
  //
  //       // child: Text(days[index],style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(0.9)),),
  //       // decoration: BoxDecoration(
  //       //     shape: BoxShape.circle,
  //       //     color: Colors.white,
  //       //     //border: (Border.all(color: Theme.of(context).primaryColor)),
  //       //     boxShadow: [
  //       //       BoxShadow(
  //       //           color: Colors.grey.shade600,
  //       //           offset: Offset(2.0, 2.0),
  //       //           blurRadius: 7.0,
  //       //           spreadRadius: .4),
  //       //       BoxShadow(
  //       //           color: Colors.white,
  //       //           offset: Offset(-2.0, -2.0),
  //       //           blurRadius: 7.0,
  //       //           spreadRadius: .3),
  //       //     ],
  //       //     gradient: LinearGradient(
  //       //         begin: Alignment.topLeft,
  //       //         end: Alignment.bottomRight,
  //       //         colors: [
  //       //           Colors.grey.shade50,
  //       //           Colors.grey.shade100,
  //       //           Colors.grey.shade200,
  //       //           Colors.grey.shade300,
  //       //         ],
  //       //         stops: [
  //       //           0.1,
  //       //           0.3,
  //       //           0.8,
  //       //           1
  //       //         ])),
  //     ),
  //   );
  // }
  
}
