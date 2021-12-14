import 'package:birdy_app/view/widgets/birddetails_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowDetailBird extends StatefulWidget {
  const ShowDetailBird({Key? key}) : super(key: key);

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
                  child: Center(child: Image.asset("assets/images/birds.png",width: 40,)),
                ),
                title: Text("bird Name",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 25
                  ),
                ),
                subtitle: Text("room2,cage1",
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
                  BirdDetailsList(title: "Canary",imageOrIcon: "name",icon: Icons.announcement_outlined),
                  BirdDetailsList(title: "the american",imageOrIcon: "breed",icon: "assets/images/icon-breed.png"),
                  BirdDetailsList(title: "yellow",imageOrIcon: "color",icon: Icons.colorize),
                  BirdDetailsList(title: "4/8/2012",imageOrIcon: "birth",icon: Icons.calendar_today_sharp),
                  BirdDetailsList(title: "male",imageOrIcon: "gender",icon: "assets/images/bird-gender.png"),
                  BirdDetailsList(title: "139",imageOrIcon: "ring",icon: "assets/images/ring-icon-number.png"),
                  BirdDetailsList(title: "ring type",imageOrIcon: "ring",icon: "assets/images/icon-ring-type.png"),










                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
