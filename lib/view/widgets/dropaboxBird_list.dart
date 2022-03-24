import 'package:birdy_app/controller/providers/cage_provider.dart';
import 'package:birdy_app/controller/providers/rooms_provider.dart';
import 'package:birdy_app/model/cage_model.dart';
import 'package:birdy_app/model/rooms_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrobList extends StatefulWidget {

  String hint;
  DrobList(
      {Key? key,
        required this.hint,

      })
      : super(key: key);

  @override
  _DrobListState createState() => _DrobListState();
}

class _DrobListState extends State<DrobList> {

  var selectedUser;
  late String selectedRoomName;
  @override

  @override
  Widget build(BuildContext context) {

    Rooms_Provider rooms_provider = Provider.of<Rooms_Provider>(context);
    CageProvider cages_provider =Provider.of<CageProvider>(context);


    return Expanded(
      child: Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.11
          ),
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Theme.of(context).primaryColor),
            //color: Theme.of(context).primaryColor
            color: Color(0xfff79281).withOpacity(0.3),
          ),
          child: widget.hint=="Rooms"?DropdownButton<Rooms_Model>(
            isExpanded: true,

            hint:  Text(widget.hint,style: TextStyle(
                color: Theme.of(context).primaryColor
            ),),
            icon: Icon(Icons.keyboard_arrow_down_rounded,

              //color: Theme.of(context).primaryColor,
            ),
            value: selectedUser,
            onChanged: (  room) {
              setState(() {
                this.selectedUser = room! ;
                selectedRoomName=room.roomName;


              });
            },
            items: rooms_provider.rooms.map((Rooms_Model room) {
              return  DropdownMenuItem(
                value: room,
                child: Row(
                  children: <Widget>[
                    Text( room.roomName,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor
                      ),

                    ),

                  ],
                ),
              );
            }).toList(),
          ):DropdownButton<Cage>(
            isExpanded: true,

            hint:  Text(widget.hint,style: TextStyle(
                color: Theme.of(context).primaryColor
            ),),
            icon: Icon(Icons.keyboard_arrow_down_rounded,
            ),

            value: selectedUser,

            onChanged: (  cage) {
              setState(() {
                this.selectedUser = cage! ;

                selectedRoomName=cage.cageName;


              });
            },
            items: cages_provider.cages.map((Cage cage) {
              return  DropdownMenuItem(
                value: cage,
                child: Row(
                  children: <Widget>[
                    Text( cage.cageName,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor
                      ),
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
