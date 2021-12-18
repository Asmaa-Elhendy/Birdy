import 'package:birdy_app/controller/providers/cage_provider.dart';
import 'package:birdy_app/controller/providers/rooms_provider.dart';
import 'package:birdy_app/model/rooms_model.dart';
import 'package:birdy_app/view/screens/all_birds.dart';
import 'package:birdy_app/view/widgets/animated_page_route.dart';
import 'package:birdy_app/view/widgets/snack_bar_delete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard.dart';


class Cages extends StatefulWidget {
  static const cageid='id';

  @override
  _CagesState createState() => _CagesState();
}

class _CagesState extends State<Cages> {
  late String newName='';
  late String newCageName='';
  var selectedUser;
  late String selectedRoomName;
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
    Rooms_Provider rooms_provider = Provider.of<Rooms_Provider>(context);
    CageProvider cageProvider=Provider.of<CageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body:   SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*.06),
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
                  borderRadius: BorderRadius.circular(25)
              ),

              child: Center(
                child: Row(
                  children: [
                    Image.asset("assets/images/manage-cages.png", width: 60,),
                    SizedBox(width: width * .06,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hello Asmaa', style: TextStyle(fontWeight: FontWeight
                            .bold),),
                        Text('manage your cages'),


                      ],)
                  ],
                ),
              ),
            ),
          ),SizedBox(height: height*.04,),
            //  Text('Select room ',style: TextStyle(color:Color(0xfff79281),fontWeight: FontWeight.bold),),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Room name',style: TextStyle(color: Color(0xfff79281),fontWeight: FontWeight.bold,fontSize:17),)
                  // DropdownButton<Rooms_Model>(
                  //   hint:  Text("Select Room",style: TextStyle(color:Color(0xfff79281),fontWeight: FontWeight.bold),),
                  //   value: selectedUser,
                  //   onChanged: (  room) {
                  //     setState(() {
                  //       this.selectedUser = room! ;
                  //       print(room.name);
                  //       selectedRoomName=room.name;
                  //
                  //
                  //     });
                  //   },
                  //  // style: TextStyle(color:Color(0xfff79281) ),
                  //   items: rooms_provider.rooms.map((Rooms_Model room) {
                  //     return  DropdownMenuItem(
                  //       value: room,
                  //       child: Row(
                  //         children: <Widget>[
                  //          Text( room.name),
                  //
                  //         ],
                  //       ),
                  //     );
                  //   }).toList(),
                  // )
                  , SizedBox(
                    height: height * .05,
                    child: ElevatedButton(
                      child: Text(
                        "ADD Cage",
                        style: TextStyle(
                          color: Color(0xfff79281),
                        ),
                      ),
                      style: ButtonStyle(
                        overlayColor:  MaterialStateProperty.all<Color>(
                            Colors.grey), //********
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                              Colors.white),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(18.0),
                                  side: BorderSide(
                                    color: Color(0xfff79281),
                                  )))),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              AlertDialog(
                                title:  Text('Add New Cage'),
                                content: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      TextField(

                                          decoration: InputDecoration(
                                            enabledBorder: const OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xfff79281), width: 0.0),
                                                borderRadius: BorderRadius.all(Radius.circular(25))
                                            ), focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xfff79281), width: 0.0),
                                              borderRadius: BorderRadius.all(Radius.circular(25))
                                          ),
                                          ),

                                          onChanged: (value) {

                                            setState(() {

                                              newCageName = value;
                                            });
                                          }),
                                    ]
                                ),
                                actions: <Widget>[

                                  Row(

                                    children: [
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();


                                        },
                                        textColor: Theme
                                            .of(context)
                                            .primaryColor,
                                        child: const Text('cancel'),
                                      ),new FlatButton(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                          cageProvider.addCage(newCageName);
                                          setState(() {
                                            newCageName='';
                                          });
                                        },
                                        textColor: Theme
                                            .of(context)
                                            .primaryColor,
                                        child: const Text('Add'),
                                      )
                                    ],mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  )
                                ],
                              )
                        );
                      },
                    ),)
                ],
              ),SizedBox(height: height*.02,),
              SizedBox(
                height: height*.55,
                child:ListView.builder(
                    itemCount: cageProvider.cages.length,
                     itemBuilder: (context, index) {
                       return InkWell(
                           onTap: (){
                             Navigator.of(context).push(createRoute(AllBirds(exist_bar: true,)));
                           },
                         child: customListtile(
                             width, height, cageProvider.cages[index].cageName,
                             context, cageProvider, index),
                       );
                     }

                ),
              ),


            ],
          ),
        ),
      ),
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
            icon: Icon(Icons.event),
            label: 'Daily tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded,),
            label: 'profile',
          ),
        ],

      ),
    );
  }
  _onTap(int index) {
    setState(() {
      selected_index=index;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard(selected_index: selected_index,)));
    });
  }
  Widget customListtile(width, hight, String name, context,
      CageProvider cageProvider, int index) {
    return Container(margin: EdgeInsets.symmetric(vertical:0.02*hight ),
      child: Row(
        children: [
          Expanded(
            child: Container(
                 margin: EdgeInsets.only(right:width * .04),
                padding: EdgeInsets.symmetric(horizontal: width * .05),
                height: hight * .07,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text('${name}'),
                    Row(
                      children: [
                        InkWell(onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialog(context,cageProvider,(){
                                  Navigator.of(context).pop();
                                  cageProvider.editCage(cageProvider.cages[index].id, newName);
                                  setState(() {
                                    newName='';
                                  });
                                },'Edit Cage Name'),
                          );
                        }, child:   Icon(Icons.edit,color: Color(0xfff79281),),

                        ),

                        SizedBox(width: width * .03,),
                        GestureDetector(
                          onTap: (){
                            ScaffoldMessenger.of(context).showSnackBar(Snack.SNackbarfun(context,
                                (){ cageProvider.deleteCage(cageProvider.cages[index].id);}
                            ));

                          },
                          child:Icon(Icons.delete_forever,color: Color(0xfff79281),),


                        )
                      ],)
                  ],)
            ),
          ),
           Image.asset("assets/images/birds.png",scale: 1.7),
           Container(
             child: CircleAvatar(
               backgroundColor: Colors.white,radius: 24,
               child: Text('${cageProvider.cages[index].birdNumbers}',style: TextStyle(color: Colors.black),),
             ),
            decoration: new BoxDecoration(
            shape: BoxShape.circle,
             border: new Border.all(
            color: Color(0xfff79281),

          ))
           )
        ],
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context,CageProvider cageProvider, function,String title){
    return new AlertDialog(
      title:  Text(title),
      content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(

                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xfff79281), width: 0.0),
                      borderRadius: BorderRadius.all(Radius.circular(25))
                  ), focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xfff79281), width: 0.0),
                    borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                ),

                onChanged: (value) {

                  setState(() {

                    newName = value;
                  });
                }),
          ]
      ),
      actions: <Widget>[

        Row(

          children: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();


              },
              textColor: Theme
                  .of(context)
                  .primaryColor,
              child: const Text('close'),
            ),new FlatButton(
              onPressed: function,
              textColor: Theme
                  .of(context)
                  .primaryColor,
              child: const Text('ok'),
            )
          ],mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        )
      ],
    );
  }
}
