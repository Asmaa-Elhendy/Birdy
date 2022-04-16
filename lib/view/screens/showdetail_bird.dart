import 'dart:io';

import 'package:birdy_app/controller/providers/bird_provider.dart';
import 'package:birdy_app/controller/providers/cage_provider.dart';
import 'package:birdy_app/model/bird_model.dart';
import 'package:birdy_app/model/cage_model.dart';
import 'package:birdy_app/model/rooms_model.dart';
import 'package:birdy_app/view/widgets/birddetails_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'all_birds.dart';

class ShowDetailBird extends StatefulWidget {
  Bird bird;
  BirdProvider birdsProvider;
  bool exist_bar = true;
  Cage? cage;
  Rooms_Model? room;
   ShowDetailBird({required this.bird,required this.birdsProvider,required this.exist_bar,this.cage,this.room});

  @override
  _ShowDetailBirdState createState() => _ShowDetailBirdState();
}

class _ShowDetailBirdState extends State<ShowDetailBird> {
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
    String? image = widget.bird.image;
    CageProvider cages_provider = Provider.of<CageProvider>(context,listen: false);
    BirdProvider birdsProvider = Provider.of<BirdProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: width *0.03,top: height*0.08),
              child: ListTile(
                leading: Container(
                  width: width*0.16,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor.withOpacity(0.3)
                  ),
                  child: widget.bird.image==null? Image.asset("assets/images/birds.png",width: 40,):
                  Image(
                      image: FileImage(
                          File(image!),
                      ),
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text(widget.bird.name,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 25
                  ),
                ),
                subtitle: Text("room ${widget.bird.roomName} cage ${widget.bird.cageName}",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15
                  ),
                ),
              ),
            ),
            Divider(color: Theme.of(context).primaryColor,),
            SingleChildScrollView(
              child: Column(
                children: [
                  BirdDetailsList(title: widget.bird.type,imageOrIcon: "name",icon: Icons.announcement_outlined),
                  BirdDetailsList(title: widget.bird.breed,imageOrIcon: "breed",icon: "assets/images/icon-breed.png"),
                  BirdDetailsList(title: widget.bird.color,imageOrIcon: "color",icon: Icons.colorize),
                  BirdDetailsList(title: widget.bird.age.toString(),imageOrIcon: "birth",icon: Icons.calendar_today_sharp),
                  BirdDetailsList(title: widget.bird.gender,imageOrIcon: "gender",icon: "assets/images/bird-gender.png"),
                  BirdDetailsList(title: widget.bird.ringNum.toString(),imageOrIcon: "ring",icon: "assets/images/ring-icon-number.png"),
                  BirdDetailsList(title: widget.bird.ringType!,imageOrIcon: "ring",icon: "assets/images/icon-ring-type.png"),

                  SizedBox(
                    height: height*0.08,
                  ),
                  RaisedButton(
                    onPressed: ()async {
                      Cage cageToEdit = await cages_provider.getCage(widget.bird.cageId);


                     widget.birdsProvider.deleteBird(widget.bird.id!);
                     int birdnum = cageToEdit.birdNumbers-1;
                     cages_provider.editCage(Cage(
                         room_id: cageToEdit.room_id,
                         wateringDays: cageToEdit.wateringDays,
                       feedingDays: cageToEdit.feedingDays,
                       cleaningDays: cageToEdit.cleaningDays,
                       roomName: cageToEdit.roomName,
                       cageName: cageToEdit.cageName,
                       id: cageToEdit.id,
                       birdNumbers: birdnum
                     ));
                     birdsProvider.readBirdByCage(widget.cage?.id);
                     // Navigator.pushReplacement(

                     //     context, MaterialPageRoute(builder: (BuildContext context) => AllBirds(exist_bar: widget.exist_bar,cage: widget.cage,room: widget.room,)));                      //Navigator.pop(context);
                       Navigator.pop(context);


                    },

                    shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(10)),
                    color: Color(0xfff79281),
                    child: Text("Delete",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal
                      ),
                    ),


                  )










                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
