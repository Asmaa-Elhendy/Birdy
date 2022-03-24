import 'package:birdy_app/controller/providers/cage_provider.dart';
import 'package:birdy_app/controller/providers/rooms_provider.dart';
import 'package:birdy_app/controller/room_db_connection.dart';
import 'package:birdy_app/model/rooms_model.dart';
import 'package:birdy_app/view/screens/cages.dart';
import 'package:birdy_app/view/screens/primary.dart';
import 'package:birdy_app/view/screens/profile.dart';
import 'package:birdy_app/view/widgets/snack_bar_delete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard.dart';

class Rooms extends StatefulWidget {
  const Rooms({Key? key}) : super(key: key);

  @override
  _RoomsState createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  late String newName;
  late String roomName="";
  late int cageCount =1;
  int selected_index=0;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Rooms_Provider rooms_provider = Provider.of<Rooms_Provider>(context,listen: false);

      rooms_provider.getdatabase();
    });
  }
  final List<Widget> _children = [
    PrimaryPage(),
    UserProfile(),
  ];

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

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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

                child: Row(
                  children: [
                    Image.asset("assets/images/manage-room.png", width: 60,),
                    SizedBox(width: width * .06,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hello Asmaa', style: TextStyle(fontWeight: FontWeight
                            .bold),),
                        Text('manage your rooms'),
                        SizedBox(
                          height: height * .05,
                          child: ElevatedButton(
                            child: Text(
                              "ADD Room",
                              style: TextStyle(
                                color: Color(0xfff79281),
                              ),
                            ),
                            style: ButtonStyle(
                                overlayColor:  MaterialStateProperty.all<Color>(
                                    Colors.grey),
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
                              // List<String> names = rooms_provider.whatName();
                              // print(names);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildAddRoomDialog(context,rooms_provider),
                              );


                            },
                          ),
                        ),

                      ],)
                  ],
                ),
              ),
            ), SizedBox(height: height * .01,),
            SizedBox(
                height: height * .7,
                child: rooms_provider.rooms.isEmpty?Center(child: Text('No Rooms ')):
                ListView.builder(
                    itemCount: rooms_provider.rooms.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Cages(room:rooms_provider.rooms[index])));
                        },
                        child: customListtile(
                            width, height, rooms_provider.rooms[index].roomName,
                            context, rooms_provider, index),
                      );
                    })
            )
          ],),
      ),   bottomNavigationBar: BottomNavigationBar(
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
      Rooms_Provider rooms_provider, int index) {
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: hight * .02, horizontal: width * .08),
        padding: EdgeInsets.symmetric(horizontal: width * .1),
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
                        _buildPopupDialog(context,rooms_provider,index),
                  );
                }, child:   Icon(Icons.edit,color: Color(0xfff79281),),

                   ),

                SizedBox(width: width * .03,),
                GestureDetector(
                  onTap: (){
                 // ScaffoldMessenger.of(context).showSnackBar(Snack.SNackbarfun(context, (){
                    ScaffoldMessenger.of(context)
                        .showSnackBar(  Snack.SNackbarfun(context, (){
                      rooms_provider.delete_room(rooms_provider.rooms[index].id);
                    }));

                 // }));
                  },
                  child:Icon(Icons.delete_forever,color: Color(0xfff79281),),


                )
              ],)
          ],)
    );
  }

  Widget _buildPopupDialog(BuildContext context,Rooms_Provider rooms_provider,int index ){
    TextEditingController namecontroller=TextEditingController();
    namecontroller..text=rooms_provider.rooms[index].roomName;
    return new AlertDialog(
      title: const Text('Edit Room Name'),
      content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
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
            ),controller: namecontroller,

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
              onPressed: () {
                Navigator.of(context).pop();
                rooms_provider.edit_room(rooms_provider.rooms[index],newName);
                setState(() {
                  newName='';
                });

              },
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
  Widget _buildAddRoomDialog(BuildContext context,Rooms_Provider rooms_provider){//**add new room*
    return new AlertDialog(
      title: const Text('Add New Room'),
      content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
                decoration: InputDecoration(
                  labelText: "Room's Name",
                  labelStyle: TextStyle(
                      color: Color(0xfff79281),
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                  ),
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
                    roomName = value;
                  });
                }),
            SizedBox(height:MediaQuery.of(context).size.height*0.034,),
            TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Number of cages",
                  labelStyle: TextStyle(
                      color: Color(0xfff79281),
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                  ),
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
                    cageCount = int.parse(value);
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
              onPressed: () {
                Navigator.of(context).pop();
                rooms_provider.addRooms(Rooms_Model(roomName: roomName,cagesCount: cageCount),cageCount);
                rooms_provider.getdatabase();

                setState(() {
                  roomName='';
               //   cageCount=1;

                });
                print(cageCount);
              },
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