import 'package:birdy_app/controller/providers/bird_provider.dart';
import 'package:birdy_app/controller/providers/cage_provider.dart';
import 'package:birdy_app/controller/providers/rooms_provider.dart';
import 'package:birdy_app/model/cage_model.dart';
import 'package:birdy_app/model/rooms_model.dart';
import 'package:birdy_app/view/screens/cages.dart';
import 'package:birdy_app/view/screens/primary.dart';
import 'package:birdy_app/view/screens/room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:birdy_app/view/widgets/TextFielBird.dart';
import 'package:birdy_app/view/widgets/dropboxAddBird.dart';
import 'package:provider/provider.dart';

import 'all_birds.dart';
import 'dashboard.dart';

class Add_bird extends StatefulWidget {
  bool cage_room_detected;
  Cage? cage;
  Rooms_Model? room;
  static ValueNotifier<String> gender = ValueNotifier("");
  static ValueNotifier<String> breed = ValueNotifier("");
  static ValueNotifier<String> type = ValueNotifier("");
  // static ValueNotifier<String> chosenRoom = ValueNotifier("");
  // static ValueNotifier<String> chosenCage = ValueNotifier("");

  Add_bird({required this.cage_room_detected, this.cage, this.room});
  @override
  _Add_birdState createState() => _Add_birdState();
}

class _Add_birdState extends State<Add_bird> {
  // PickedFile? imageFile = null;
  PickedFile? imageFile = null;

  final _formKey = GlobalKey<FormState>();
  final birdTypeConroller = TextEditingController();
  final birdBreadConroller = TextEditingController();
  final birdNameConroller = TextEditingController();
  final birdColorConroller = TextEditingController();
  final birdAgeConroller = TextEditingController();
  final ringNumberConroller = TextEditingController();
  final ringTypeConroller = TextEditingController();
  var selectedUserRoom;
  var selectedUserCage;
  String chosenRoom = "";
  //CageProvider cages_provider = Provider.of<CageProvider>(_,listen: false);

  late Cage cage;
  late Rooms_Model room;

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
  void initState() {
    Rooms_Provider rooms_provider =
        Provider.of<Rooms_Provider>(context, listen: false);
    rooms_provider.getdatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    BirdProvider birdsProvider = Provider.of<BirdProvider>(context);
    CageProvider cages_provider =
        Provider.of<CageProvider>(context, listen: false);

    //rooms_provider.getdatabase();

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
                                  controllerValue: birdNameConroller,
                                  size: width * 0.8,
                                ),
                                BirdForm(
                                    label: "Bird Color",
                                    icon: Icons.colorize,
                                    controllerValue: birdColorConroller,
                                    size: width * 0.8),
                                Row(
                                  children: <Widget>[
                                    BirdForm(
                                      label: "Ring Num",
                                      icon:
                                          "assets/images/ring-icon-number.png",
                                      controllerValue: ringNumberConroller,
                                      size: width * 0.4,
                                    ),
                                    SizedBox(
                                      width: width * 0.036,
                                    ),
                                    BirdForm(
                                      label: "Ring Type",
                                      icon: "assets/images/icon-ring-type.png",
                                      controllerValue: ringTypeConroller,
                                      size: width * 0.4,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    BirdForm(
                                        label: "Bird age",
                                        icon: Icons.calendar_today_sharp,
                                        controllerValue: birdAgeConroller,
                                        size: width * 0.4),
                                    SizedBox(
                                      width: width * 0.036,
                                    ),
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
                                    SizedBox(
                                      width: width * 0.036,
                                    ),
                                    DropDown(
                                      hint: 'Type',
                                      list: ['Canary', 'Beak'],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: hight * 0.015,
                                ),
                                widget.cage_room_detected
                                    ? Container()
                                    : Row(
                                        children: [
                                          // DropDown(
                                          //   hint: 'Rooms',
                                          //   list: roomName,
                                          // ),
                                          //DrobList(hint:"Rooms"),
                                          droblist("Rooms"),
                                          SizedBox(
                                            width: width * 0.036,
                                          ),
                                          //droblist("Cages"),

                                          //DrobList(hint: "Cages"),

                                          //Spacer(),
                                          chosenRoom == ""
                                              ? Container()
                                              :
                                              // ValueListenableBuilder(
                                              //   valueListenable: Add_bird.chosenRoom,
                                              //
                                              //  builder: (BuildContext context, String rooms,Widget? child){

                                              droblist("Cages"),
                                          //DrobList(hint: "Cages");

                                          //},

                                          //)
                                          //DrobList(hint: "Cages"),
                                        ],
                                      ),
                                SizedBox(
                                  height: hight * 0.02,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: RaisedButton(
                                    onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          String? im;
                                          if (imageFile != null) {
                                            im = imageFile!.path;
                                          } else {
                                            im = null;
                                          }
                                          Cage usedCage;
                                          Rooms_Model usedRoom;
                                          if (widget.cage_room_detected) {
                                            usedCage = widget.cage!;
                                            usedRoom = widget.room!;
                                          } else {
                                            usedCage = cage;
                                            usedRoom = room;
                                          }

                                          // birdsProvider.addBird(birdNameConroller.text, Add_bird.type.value, Add_bird.gender.value, birdColorConroller.text,int.parse(birdAgeConroller.text) , ringTypeConroller.text, int.parse(ringNumberConroller.text), Add_bird.breed.value, im, usedCage.id!, usedRoom.id, usedCage.cageName, usedRoom.roomName);
                                          birdsProvider.addBird(
                                            name: birdNameConroller.text,
                                            age: int.parse(
                                                birdAgeConroller.text),
                                            ringType: ringTypeConroller.text,
                                            ringNum: int.parse(
                                                ringNumberConroller.text),
                                            image: im,
                                            breed: Add_bird.breed.value,
                                            type: Add_bird.type.value,
                                            color: birdColorConroller.text,
                                            gender: Add_bird.gender.value,
                                            cageName: usedCage.cageName,
                                            roomName: usedRoom.roomName,
                                            roomId: usedRoom.id,
                                            cageId: usedCage.id!,
                                          );
                                          int birdnum =
                                              usedCage.birdNumbers + 1;
                                          Cage cageToEdit = Cage(
                                              cageName: usedCage.cageName,
                                              roomName: usedCage.roomName,
                                              cleaningDays:
                                              usedCage.cleaningDays,
                                              feedingDays: usedCage.feedingDays,
                                              wateringDays:
                                              usedCage.wateringDays,
                                              room_id: usedCage.room_id,
                                              birdNumbers: birdnum,
                                              id: usedCage.id);
                                          cages_provider.editCage(cageToEdit);
                                          // widget.cage_room_detected?birdsProvider.addBird(birdNameConroller.text, Add_bird.type.value, Add_bird.gender.value, birdColorConroller.text,int.parse(birdAgeConroller.text) , ringTypeConroller.text, int.parse(ringNumberConroller.text), Add_bird.breed.value, im, widget.cage!.id!, widget.room!.id, widget.cage!.cageName, widget.room!.roomName)
                                          //     :birdsProvider.addBird(
                                          //     birdNameConroller.text, Add_bird.type.value, Add_bird.gender.value, birdColorConroller.text,int.parse(birdAgeConroller.text) , ringTypeConroller.text, int.parse(ringNumberConroller.text), Add_bird.breed.value,
                                          //     im,
                                          //     cage!.id!, room!.id, cage!.cageName,room!.roomName
                                          //
                                          // );
                                          setState(() {
                                            selectedUserRoom = null;
                                            selectedUserCage = null;
                                          });

                                          //print(birdTypeConroller.text);
                                          //print(birdB)
                                          const snackBar = SnackBar(
                                            content: Text('Your Bird is added successfully '),
                                          );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                          widget.cage_room_detected
                                              ? Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                  context) =>
                                                      Add_bird(
                                                        cage: widget.cage!,
                                                        cage_room_detected:
                                                        widget
                                                            .cage_room_detected,
                                                        room: widget.room!,
                                                      )))
                                              : Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                  context) =>
                                                      Add_bird(
                                                          cage_room_detected:
                                                          widget
                                                              .cage_room_detected)));
                                          // .then((value) => setState(() {
                                          //     Provider. of<CageProvider>(context,listen: false). dispose();
                                          //     // Provider. of<Rooms_Provider>(context,listen: false). dispose();
                                          //     // Provider. of<BirdProvider>(context,listen: false). dispose();
                                          //
                                          //
                                          //   }));

                                          // Navigator.pushReplacementNamed(context, Dashboard.dashboardid).then((value) => setState(() {
                                          //   Provider. of<CageProvider>(context,listen: false). dispose();
                                          //   // Provider. of<Rooms_Provider>(context,listen: false). dispose();
                                          //   // Provider. of<BirdProvider>(context,listen: false). dispose();
                                          //
                                          //
                                          // }));

                                        }
                                   //   }

                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Color(0xfff79281),
                                    child: Text(
                                      "Add Bird",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
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
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    //Navigator.of(context).pop();
    //Navigator.pop(context);
    //Navigator.of(context,rootNavigator: true).pop();
  }

  Widget droblist(String hint) {
    String selectedRoomName;
    String selectedCageName;
    Rooms_Provider rooms_provider = Provider.of<Rooms_Provider>(context);
    CageProvider cages_provider = Provider.of<CageProvider>(context);
    List<Cage> itom = cages_provider.usedCageInDrop;

    //rooms_provider.getdatabase();

    return Expanded(
      child: Container(
        padding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.11),
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Theme.of(context).primaryColor),
          //color: Theme.of(context).primaryColor
          color: Color(0xfff79281).withOpacity(0.3),
        ),
        child: hint == "Rooms"
        //**************************************************
        //**************************
        //***************
            ?  DropdownButtonFormField<Rooms_Model>(
          decoration: InputDecoration(
              enabledBorder: InputBorder.none,
          ),
                isExpanded: true,
                hint: Text(
                  hint,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
          validator: (value) => value == null
              ? 'Please choose your room': null,
               // underline: SizedBox(),
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,

                  //color: Theme.of(context).primaryColor,
                ),
                value: selectedUserRoom,
                onTap: () {
                  setState(() {
                    chosenRoom = "";
                    selectedUserCage = null;
                  });
                  //item = await cages_provider.readAllCages();
                },
                onChanged: (room) async {
                  setState(() {
                    this.selectedUserRoom = room!;
                    selectedRoomName = room.roomName;
                    chosenRoom = room.roomName;
                    this.room = room;

                    // Add_bird.chosenRoom..value = selectedRoomName;
                    // item =  cages_provider.getRoomCage(room.id) as List<Cage>;
                  });
                  cages_provider.getCageForDrop(room!.id);

                  //cages_provider.getRoomCage(room!.id);
                  // setState(() {
                  //   itom = cages_provider.need;
                  // });

                  // setState(() async*{
                  //   item =  await cages_provider.getRoomCage(room!.id);
                  //
                  // });
                },
                items: rooms_provider.rooms.map((Rooms_Model room) {
                  return DropdownMenuItem(
                    value: room,
                    child: Row(
                      children: <Widget>[
                        Text(
                          room.roomName,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )
            : DropdownButtonFormField<Cage>(
                isExpanded: true,
          validator: (value) => value == null
              ? 'Please choose your cage': null,
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
          ),
                hint: Text(
                  hint,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                ),

                value: selectedUserCage,
                // onTap: () async {
                //   item = await cages_provider.getRoomCage(room.id);
                // },

                onChanged: (cage) {
                  setState(() {
                    this.selectedUserCage = cage!;

                    selectedCageName = cage.cageName;
                    this.cage = cage;
                    //Add_bird.chosenCage.value = cage.cageName;
                  });
                },
                items: cages_provider.usedCageInDrop.map((Cage cage) {
                  //items: itom.map((Cage cage) {
                  return DropdownMenuItem(
                    value: cage,
                    child: Row(
                      children: <Widget>[
                        Text(
                          cage.cageName,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
