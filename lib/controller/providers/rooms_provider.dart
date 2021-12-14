import 'package:birdy_app/model/rooms_model.dart';
import'package:flutter/material.dart';

class Rooms_Provider with ChangeNotifier{
  List<Rooms_Model> _rooms =[
    Rooms_Model(
        id: "1",
        name: "Office Room",
        cagesCount: 1
    ),
    Rooms_Model(
      id: "2",
      name: "Home Room",
      cagesCount: 1,
    ),
    Rooms_Model(
      id: "3",
      name: "Home Room2",
      cagesCount: 1,
    ),
  ];

  List <Rooms_Model> get rooms{
    return [..._rooms];  //copy list
  }

  List<String> RoomsName (){
    List<String> names = [];
    for(int i =0; i<_rooms.length; i++){
      names.add(rooms[i].name);
    }
    print(names);
    notifyListeners();

    return names;

  }
  addRooms(String name, int num){
    if(name==""){

      return true;
    }
    if(num==null){
      num = 1;
    }
    final newRoom = Rooms_Model(id:  DateTime.now().toString(), name: name, cagesCount: num);
    print("rooms cage is $num");
    _rooms.add(newRoom);
    notifyListeners();
  }

  edit_room(String id, String newName){
    final roomIndex = _rooms.indexWhere((room) => room.id == id);
    if(newName==''){
      return true;
    }
    if(roomIndex >= 0){
      _rooms[roomIndex] = Rooms_Model(id: id, name: newName,cagesCount: _rooms[roomIndex].cagesCount);
      print(_rooms[roomIndex].cagesCount);
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