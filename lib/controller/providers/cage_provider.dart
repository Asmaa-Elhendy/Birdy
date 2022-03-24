import 'package:birdy_app/controller/db/cages_database.dart';
import 'package:birdy_app/model/cage_model.dart';
import 'package:flutter/material.dart';
class CageProvider extends ChangeNotifier{

  List<Cage> _cages=[];

  List<Cage> _needCages=[];

  List<Cage> get cages{
    return [..._cages];
  }
  List<Cage> get need{
    return [..._needCages];
  }


  Future readAllCages (int roomid)async {
   //List<Cage> allcages =[];
   List<Cage> allcages = await CagesDatabase.instance.readAllCages();
   _cages = allcages;
   getRoomCage(roomid, cages);


  // return allcages;
  }



  Future<Cage> getCage(id) async{
    Cage cage = await CagesDatabase.instance.readCage(id);
    return cage;

  }


    getRoomCage(int roomid,List allCages)
   {
    //readAllCages();
    List<Cage> cage=[];

    if(allCages.isNotEmpty) {
      for (int i = 0; i < allCages.length; i++) {
        if (allCages[i].room_id == roomid) {
          cage.add(allCages[i]);
        }
      }
    }
    _needCages = cage;
    notifyListeners();

    }
    // List<Cage> allCages = await CagesDatabase.instance.readAllCages();
    // List cageroom = [];
    // for(int i =0;i<allCages.length;i++) {
    //   if (allCages[i].room_id == roomid) {
    //     cageroom.add(allCages[i]);
    //   }
    //}
      //notifyListeners();
      //return cageroom;



  //}

  Future addCage(String name,int roomid,int birdnum,cleaning,feeding,watering ) async{
    final newCage= Cage(cageName: name, room_id: roomid, birdNumbers: birdnum,feedingDays: feeding,cleaningDays: cleaning,wateringDays: watering);
    await CagesDatabase.instance.create(newCage);
    print("newcage in add name ${newCage.cageName}, tasks feed${newCage.feedingDays},water ${newCage.wateringDays}, clean${newCage.cleaningDays}");

    notifyListeners();

  }

  // void addCage( String name){
  //
  //   //final newCage= Cage(id:  DateTime.now().toString(), cageName: name);
  //   final newCage= Cage(id:  5, cageName: name);
  //
  //   _cages.add(newCage);
  //   notifyListeners();
  // }

  editCage(Cage cage) async{
    final newCage = cage.copy(
      room_id: cage.room_id,
      cageName: cage.cageName,
      wateringDays: cage.wateringDays,
      feedingDays: cage.feedingDays,
      cleaningDays: cage.cleaningDays,
      birdNumbers: cage.birdNumbers,
    );
    await CagesDatabase.instance.update(newCage);
    notifyListeners();


      // final cageindex = _cages.indexWhere((cage) => cage.id == id);
      // if(newname==''){
      //   return true;
      // }
      // if(cageindex >= 0){
      //   _cages[cageindex] = Cage(id: id, cageName: newname);
      //   notifyListeners();
      // }else{
      //   print('there is a mistake');
      // }
  }

  deleteCage(int id) async{
   await CagesDatabase.instance.delete(id);

   // _cages.removeWhere((cage) => cage.id==id);
    notifyListeners();
 }
}