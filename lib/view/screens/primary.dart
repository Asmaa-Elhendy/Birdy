
import 'package:birdy_app/view/screens/all_birds.dart';
import 'package:birdy_app/view/screens/bird.dart';
import 'package:birdy_app/view/screens/create_new_password.dart';
import 'package:birdy_app/view/screens/room.dart';
import 'package:birdy_app/view/widgets/animated_page_route.dart';
import 'package:flutter/material.dart';

import 'cages.dart';

class PrimaryPage extends StatefulWidget {
  const PrimaryPage({Key? key}) : super(key: key);

  @override
  _PrimaryPageState createState() => _PrimaryPageState();
}

class _PrimaryPageState extends State<PrimaryPage> {
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double hight=MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding:  EdgeInsets.only(left: width*.04,top: hight*.07,bottom: hight*.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(top:0.0),
                  child: Text('Hello breeder',style: TextStyle(color: Color(0xfff79281),fontWeight: FontWeight.bold,fontSize: 20)),
                ),
                Text('Be excited to follow your birds.',style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
          SizedBox(
            height: hight*.15,

            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*.1),   //center*****************************
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  InkWell(
                    onTap: (){
                   Navigator.of(context).push(createRoute(Rooms()));
                    },
                    child:  container_listview(width, hight,'Room','assets/images/chat-room.png'),
                  ),
               //   SizedBox(width: width*.06,),

                  // InkWell(
                  //   onTap: (){
                  //     Navigator.of(context).push(createRoute(Cages()));
                  //   },
                  //   child: container_listview(width, hight, 'Cage','assets/images/cageblack.png'),
                  // ),
                  SizedBox(width: width*.06,),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(createRoute(AllBirds(exist_bar: false,)));
                    },
                    child: container_listview(width, hight, 'Bird','assets/images/dove.png'),
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}

Widget container_listview(double width,double hight,String title,String path){
  return  Container(
    width: width*.2,
    padding: EdgeInsets.symmetric(horizontal:width*.04,vertical:hight*.03),
    decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xfff79281).withOpacity(.2)
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Icon(icon,color: Color(0xfff79281),),
        Image.asset(path),
        Text('$title',style: TextStyle(color: Color(0xfff79281),fontWeight: FontWeight.w600),)
      ],),
  );
}

