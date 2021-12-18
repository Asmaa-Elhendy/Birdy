import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:birdy_app/view/widgets/TextFielBird.dart';
import 'package:birdy_app/view/widgets/dropboxAddBird.dart';
import 'package:birdy_app/view/widgets/dropaboxBird_list.dart';

import 'dashboard.dart';

class Add_bird extends StatefulWidget {
  bool cage_room_detected;
  Add_bird(this.cage_room_detected);
  @override
  _Add_birdState createState() => _Add_birdState();
}

class _Add_birdState extends State<Add_bird> {
  PickedFile? imageFile = null;

  final _formKey = GlobalKey<FormState>();
  final birdTypeConroller = TextEditingController();
  final birdBreadConroller  = TextEditingController();
  final birdNameConroller  = TextEditingController();
  final birdColorConroller  = TextEditingController();
  final birdAgeConroller  = TextEditingController();
  final ringNumberConroller  = TextEditingController();
  final ringTypeConroller  = TextEditingController();

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add Photo From:"),
            elevation: 20,
            actions: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          _openCamera(context);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Camera Roll',
                          style:
                          TextStyle(color: Theme.of(context).primaryColor),
                        )),
                    TextButton(
                        onPressed: () {
                          _openGallery(context);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Gallery',
                          style:
                          TextStyle(color: Theme.of(context).primaryColor),
                        )),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;


    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus;
        currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: hight * .05,
              ),
              Center(
                child: Container(
                  width: width * .85,
                  height: hight * .15,
                  padding: EdgeInsets.all(hight * .03),
                  decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(.1),
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/manage-birds.png",
                        width: 60,
                      ),
                      SizedBox(
                        width: width * .06,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Hello Tasneem',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Add New Bird'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: hight * .04,
              ),
              Padding(
                padding:
                EdgeInsets.only(right: width * 0.035, left: width * 0.035),
                child: Container(
                  height: hight * 0.95,
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      left: width * 0.04,
                      right: width * 0.04,
                      top: hight * 0.034),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Center(
                            child: CircleAvatar(
                              backgroundColor: Color(0xfff79281).withOpacity(.2),
                              radius: 40,
                              child: imageFile == null
                                  ? GestureDetector(
                                child: Icon(
                                  Icons.add_photo_alternate_outlined,
                                  color: Theme.of(context).primaryColor,
                                  size: 40,
                                ),
                                onTap: () {
                                  _showChoiceDialog(context);
                                },
                              )
                                  : Stack(
                                children: [
                                  CircleAvatar(
                                      radius: 40,
                                      backgroundImage: Image.file(
                                        File(
                                          imageFile!.path,
                                        ),
                                        fit: BoxFit.cover,
                                      ).image),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: hight * 0.084,
                                        left: width * 0.13),
                                    child: InkWell(
                                      child: Icon(
                                        Icons.edit,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onTap: () {
                                        _showChoiceDialog(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: hight * 0.03,
                        ),
                        Form(
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            key: _formKey,
                            child: Column(
                              children: [
                                BirdForm(
                                  label: "Bird name",
                                  icon: Icons.announcement,
                                  controllerValue: birdNameConroller ,
                                  size: width * 0.8,
                                ),
                                BirdForm(
                                    label: "Bird Color",
                                    icon: Icons.colorize,
                                    controllerValue: birdColorConroller ,
                                    size: width * 0.8),
                                Row(
                                  children: <Widget>[
                                    BirdForm(
                                      label: "Ring Num",
                                      icon:
                                      "assets/images/ring-icon-number.png",
                                      controllerValue: ringNumberConroller ,
                                      size: width * 0.4,
                                    ),
                                    SizedBox(width: width*0.036,),
                                    BirdForm(
                                      label: "Ring Type",
                                      icon: "assets/images/icon-ring-type.png",
                                      controllerValue: ringTypeConroller ,
                                      size: width * 0.4,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    BirdForm(
                                        label: "Bird age",
                                        icon: Icons.calendar_today_sharp,
                                        controllerValue: birdAgeConroller ,
                                        size: width * 0.4),
                                    SizedBox(width: width*0.036,),
                                    DropDown(
                                        hint: "gender",
                                        list: ['male', 'female', 'new born']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    DropDown(
                                      hint: 'Breed',
                                      list: ['Australian', 'panama'],
                                    ),
                                    SizedBox(width: width*0.036,),
                                    DropDown(
                                      hint: 'Type',
                                      list: ['Canary', 'Beak'],
                                    )

                                  ],
                                ),
                                SizedBox(height: hight*0.015,),
                                widget.cage_room_detected?Container():Row(
                                  children: [
                                    // DropDown(
                                    //   hint: 'Rooms',
                                    //   list: roomName,
                                    // ),
                                    DrobList(hint:"Rooms"),
                                    SizedBox(width: width*0.036,),



                                    //Spacer(),
                                    DrobList(hint: "Cages"),

                                  ],
                                ),
                                SizedBox(
                                  height: hight*0.02,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width*0.8,
                                  height: MediaQuery.of(context).size.height*0.07,
                                  child: RaisedButton(onPressed: (){
                                    //print("room is$roomName");

                                    if (_formKey.currentState!.validate()) {
                                      print(birdTypeConroller.text);
                                      //print(birdB)
                                    }
                                  },
                                    shape: RoundedRectangleBorder(

                                        borderRadius: BorderRadius.circular(10)),
                                    color: Color(0xfff79281),
                                    child: Text("Add Bird",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal
                                      ),
                                    ),

                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }



  // Widget _drobbx(){
  //   var selectedUser;
  //   return Container(
  //         padding: EdgeInsets.only(
  //             left: MediaQuery.of(context).size.width * 0.11
  //         ),
  //         width: MediaQuery.of(context).size.width * 0.4,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(15),
  //           border: Border.all(color: Theme.of(context).primaryColor),
  //           //color: Theme.of(context).primaryColor
  //           color: Color(0xfff79281).withOpacity(0.3),
  //         ),
  //     child:  DropdownButton<Rooms_Model>(
  //       hint:  Text("Select Room",style: TextStyle(color:Color(0xfff79281),fontWeight: FontWeight.bold),),
  //       value: selectedUser,
  //       onChanged: (  room) {
  //         setState(() {
  //           this.selectedUser = room! ;
  //           print(room.name);
  //           selectedRoomName=room.name;
  //
  //
  //         });
  //       },
  //       // style: TextStyle(color:Color(0xfff79281) ),
  //       items: rooms_provider.rooms.map((Rooms_Model room) {
  //         return  DropdownMenuItem(
  //           value: room,
  //           child: Row(
  //             children: <Widget>[
  //               Text( room.name),
  //
  //             ],
  //           ),
  //         );
  //       }).toList(),
  //     ),,
  //   );
  //
  // }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile!;

    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    Navigator.pop(context);
  }
}
