import 'package:birdy_app/view/screens/showdetail_bird.dart';
import 'package:flutter/material.dart';

class Card_bird extends StatelessWidget {
  String BirdName;

   Card_bird({
   required this.BirdName
  });

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
              // offset: Offset(
              //   2.0, // Move to right 10  horizontally
              //   2.0, // Move to bottom 10 Vertically
              // ),
            )
          ],
        ),
        child: ListTile(
         leading: Image.asset("assets/images/birds.png",width: 40,),
         title: Text("$BirdName",
           style: TextStyle(
             color: Colors.black,
             fontWeight: FontWeight.w600,
             fontSize: 15,
           ),
         ),
          trailing: FlatButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowDetailBird()),
              );
            },
            child: Text("show details",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 12,

              ),
            ),
          ),
        ),
      ),
    );


  }
}
