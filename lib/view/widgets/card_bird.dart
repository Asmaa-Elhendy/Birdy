import 'dart:io';

import 'package:birdy_app/controller/providers/bird_provider.dart';
import 'package:birdy_app/model/bird_model.dart';
import 'package:birdy_app/model/cage_model.dart';
import 'package:birdy_app/model/rooms_model.dart';
import 'package:birdy_app/view/screens/showdetail_bird.dart';
import 'package:flutter/material.dart';

class Card_bird extends StatelessWidget {
  Bird bird;
  BirdProvider birdsProvider;
  bool exist_bar = true;
  Cage? cage;
  Rooms_Model? room;

   Card_bird({
   required this.bird,
     required this.birdsProvider,
     required this.exist_bar,this.room,this.cage
  });

  @override
  Widget build(BuildContext context) {

    String? image = bird.image;

    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: width*0.05, vertical: height*0.01),
      child: Container(
        width: width,
        height: height * 0.091,
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,

          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow

            )
          ],
        ),
        child: Padding(
          padding:  EdgeInsets.only(left: width*0.0002),
          child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                bird.image==null?Image.asset("assets/images/birds.png",width: 40,)
                     :CircleAvatar(

                   radius: 27,
                     backgroundImage: Image.file(File(image!),fit: BoxFit.cover,).image,

                 ),
          Text(bird.name,
               style: TextStyle(
                 color: Colors.black,
                 fontWeight: FontWeight.w600,
                 fontSize: 15,
               ),
             ),
          FlatButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowDetailBird(bird: bird,birdsProvider: birdsProvider,exist_bar: exist_bar,cage: cage,room: room,)),
                  );
                },
                child: Text("show details",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 12,

                  ),
                ),
              ),


              ],
            )
          // ListTile(
          //  leading: bird.image==null?Image.asset("assets/images/birds.png",width: 40,)
          //      :Container(
          //    margin: EdgeInsets.only(left: width*0.0001,top: height*0.01),
          //        child: CircleAvatar(
          //
          //    radius: 30,
          //        backgroundImage: Image.file(File(image!),fit: BoxFit.cover,).image,
          //
          //  ),
          //      ),
          //  title: Text(bird.name,
          //    style: TextStyle(
          //      color: Colors.black,
          //      fontWeight: FontWeight.w600,
          //      fontSize: 15,
          //    ),
          //  ),
          //   trailing: FlatButton(
          //     onPressed: (){
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => ShowDetailBird()),
          //       );
          //     },
          //     child: Text("show details",
          //       style: TextStyle(
          //         color: Theme.of(context).primaryColor,
          //         fontSize: 12,
          //
          //       ),
          //     ),
          //   ),
          // ),
        ),
      ),
    );


  }
}
