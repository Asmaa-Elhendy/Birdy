import 'package:birdy_app/controller/providers/rooms_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Rooms extends StatefulWidget {
  const Rooms({Key? key}) : super(key: key);

  @override
  _RoomsState createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  late String newName;


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double hight = MediaQuery
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
              height: hight * .05,
            ),
            Center(
              child: Container(
                width: width * .85,
                height: hight * .17,
                padding: EdgeInsets.all(hight * .03),
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
                          height: hight * .05,
                          child: ElevatedButton(
                            child: Text(
                              "ADD Room",
                              style: TextStyle(
                                color: Color(0xfff79281),
                              ),
                            ),
                            style: ButtonStyle(
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
                            onPressed: () {},
                          ),
                        ),

                      ],)
                  ],
                ),
              ),
            ), SizedBox(height: hight * .01,),
            SizedBox(
                height: hight * .75,
                child: ListView.builder(
                    itemCount: rooms_provider.rooms.length,
                    itemBuilder: (context, index) {
                      return customListtile(
                          width, hight, rooms_provider.rooms[index].name,
                          context, rooms_provider, index);
                    })
            )
          ],),
      ),
    );
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
                },

                    child: Image.asset("assets/images/edit.png", width: 30,),
                  ),

                SizedBox(width: width * .03,),
                GestureDetector(
                  onTap: (){
                    rooms_provider.delete_room(rooms_provider.rooms[index].id);
                  },
                  child: Image.asset("assets/images/delete-activate.png", width: 30,),
                )
              ],)
          ],)
    );
  }

  Widget _buildPopupDialog(BuildContext context,Rooms_Provider rooms_provider,int index ){
    return new AlertDialog(
      title: const Text('Edit Room Name'),
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
              onPressed: () {
                Navigator.of(context).pop();
                rooms_provider.edit_room(rooms_provider.rooms[index].id, newName);
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
}