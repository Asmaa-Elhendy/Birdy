import 'package:birdy_app/controller/db/cages_database.dart';
import 'package:birdy_app/controller/room_db_connection.dart';
import 'package:birdy_app/model/cage_model.dart';
import 'package:birdy_app/model/rooms_model.dart';
import'package:flutter/material.dart';

class Rooms_Provider with ChangeNotifier{
  List<Map<String,dynamic>> _roomsmap =[];
 List<Rooms_Model> _rooms=[];
 
 
 
  List<Rooms_Model> get rooms{
    return [..._rooms];  //copy list
  }

  // List<String> RoomsName (){
  //   List<String> names = [];
  //   for(int i =0; i<_rooms.length; i++){
  //     names.add(rooms[i].roomName);
  //   }
  //   print(names);
  //   notifyListeners();
  //
  //   return names;
  //
  // }
  getdatabasefortask(int i)async{
    _roomsmap=  await DatabaseConnection.getRoomDatabase();
    _rooms= _roomsmap.map((room) => Rooms_Model(id:room['id'],roomName: room['roomName'],cagesCount: room['cagesCount'])).toList();
    notifyListeners();
    return _rooms[i];
  }
  getdatabase()async{
  _roomsmap=  await DatabaseConnection.getRoomDatabase();
  _rooms= _roomsmap.map((room) => Rooms_Model(id:room['id'],roomName: room['roomName'],cagesCount: room['cagesCount'])).toList();
     notifyListeners();
     return _rooms;
    }


  addRooms(Rooms_Model room, int cage_count,String roomname) async {
    if(room.roomName==""){

      return true;
    }
    if(room.cagesCount==null){
      room.cagesCount = 0;
    }
  int id=await DatabaseConnection.addRoom(room);
    print(rooms);

    if(cage_count>0){
      for(int i=1;i<=cage_count;i++){
        final newCage= Cage(cageName: "$i", room_id: id, birdNumbers: 0,feedingDays: "Monday Tuesday Wednesday Thursday Friday Saturday Sunday",cleaningDays: "Monday Tuesday Wednesday Thursday Friday Saturday Sunday",wateringDays: "Monday Tuesday Wednesday Thursday Friday Saturday Sunday",roomName: roomname);
        await CagesDatabase.instance.create(newCage);
      }
    }

    notifyListeners();



  }

  edit_room(Rooms_Model room, String newName){
    DatabaseConnection().editroom(room, newName);
    getdatabase();
    notifyListeners();
    // final roomIndex = _rooms.indexWhere((room) => room.id == id);
    // if(newName==''){
    //   return true;
    // }
    // if(roomIndex >= 0){
    //  // _rooms[roomIndex] = Rooms_Model(id: id, name: newName,cagesCount: _rooms[roomIndex].cagesCount);
    //   print(_rooms[roomIndex].cagesCount);
    //   notifyListeners();
    // }else{
    //   print('there is a mistake');
    // }

  }
  void delete_room(int id){
   // _rooms.removeWhere((room) => room.id == id);
    DatabaseConnection().deleteroom(id);
    getdatabase();
    notifyListeners();
  }



}