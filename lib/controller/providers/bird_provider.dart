import 'package:birdy_app/controller/db/cages_database.dart';
import 'package:birdy_app/model/bird_model.dart';
import 'package:flutter/cupertino.dart';

import '../room_db_connection.dart';

class BirdProvider extends ChangeNotifier{
  List<Bird> _birds=[];

  List<Bird> _needBirds=[];

  List<Bird> get birds{
    return [..._birds];
  }
  List<Bird> get needBirds{
    return [..._needBirds];
  }

  Future readAllBirds ()async {
    //List<Cage> allcages =[];
    //List<Bird> allBirds = await CagesDatabase.instance.readAllCages();
    // List<Bird> allBirds = await Birds_Helper.readAllBirds();
    List<Bird> allBirds = await CagesDatabase.instance.readAllBirds();
    _birds = allBirds;
    notifyListeners();

  }
  Future addBird({required String name, required String type, required String gender,required String color,required int age,String? ringType,int? ringNum,required String breed,String? image, required int cageId,required int roomId,required String cageName,required String roomName}  ) async{
    final newBird= Bird(roomName: roomName,cageName: cageName,cageId: cageId,roomId: roomId,age: age,breed: breed,gender: gender,type: type,name: name,color: color,ringType: ringType,ringNum: ringNum,image: image );
    //await Birds_Helper.create(newBird);
    await CagesDatabase.instance.createBird(newBird);
    print('its add bird in provider');

    notifyListeners();

  }
  Future<List<Bird>> readBirdByCage(id) async{
    List<Bird> need =await CagesDatabase.instance. readBirdByCageId(id);
    _needBirds = need;
    notifyListeners();


    return need;
  }

  deleteBird(int id) async{
    await CagesDatabase.instance.deleteBird(id);
    notifyListeners();
  }



}