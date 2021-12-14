import 'package:birdy_app/view/screens/bird.dart';
import 'package:birdy_app/view/widgets/animated_page_route.dart';
import 'package:birdy_app/view/widgets/card_bird.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';

class AllBirds extends StatefulWidget {
  bool exist_bar=true;
  AllBirds({required this.exist_bar});

  @override
  _AllBirdsState createState() => _AllBirdsState();
}

class _AllBirdsState extends State<AllBirds> {
  int selected_index=0;
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
    bottomNavigationBar: BottomNavigationBar(
        selectedItemColor:Color(0xfff79281) ,
    currentIndex: selected_index,
    onTap: _onTap,
    items: <BottomNavigationBarItem> [
    BottomNavigationBarItem(
    icon: Icon(Icons.home,),
    label: 'Home',

    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.account_circle_rounded,),
    label: 'profile',
    ),
    ],

    ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(createRoute(Add_bird(widget.exist_bar)));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xfff79281),
        tooltip: 'add bird',
      ),
      body: Container(
        height: height,
        padding: EdgeInsets.only(top: height*0.07),

        child: Column(
          children: [
            Center(
              child: Image.asset("assets/images/cage-birds.png", width: 60,),
            ),
           widget.exist_bar? Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.07,vertical: height*0.02),
              child: Container(
                width: width,
                height: height*0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xfff79281).withOpacity(0.3),
                ),
                child: Center(child: Text("room2, cage1",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16
                  ),
                )),
              ),
            ):Container(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.07,vertical: height*0.022),
              child: SizedBox(height:widget.exist_bar? height*.58:height*.67,child:

                ListView.builder(
                  itemCount: 15,
                  itemBuilder:(BuildContext context,int index) {
                    return Card_bird(BirdName: "Canary");
                  },


                ),

              )

            )

          ],
        ),
      ),

    );
  }
  _onTap(int index) {
    setState(() {
      selected_index=index;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard(selected_index: selected_index,)));
    });
  }
}