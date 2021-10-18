import 'package:birdy_app/model/rooms_model.dart';
import'package:flutter/material.dart';

class Rooms_Provider with ChangeNotifier{
  List<Rooms_Model> _rooms =[
    Rooms_Model(
        id: "1",
        name: "Office Room"
    ),
    Rooms_Model(
        id: "2",
        name: "Home Room"
    ),
    Rooms_Model(
        id: "3",
        name: "Home Room2"
    ),
  ];

  List <Rooms_Model> get rooms{
    return [..._rooms];  //copy list
  }
  void addRooms(String name){
    final newRoom = Rooms_Model(id:  DateTime.now().toString(), name: name);
    _rooms.add(newRoom);
    notifyListeners();
  }

   edit_room(String id, String newName){
    final roomIndex = _rooms.indexWhere((room) => room.id == id);
    if(newName==''){
      return true;
    }
    if(roomIndex >= 0){
      _rooms[roomIndex] = Rooms_Model(id: id, name: newName);
      notifyListeners();
    }else{
      print('there is a mistake');
    }

  }
  void delete_room(String id){
    _rooms.removeWhere((room) => room.id == id);
    notifyListeners();
  }



}