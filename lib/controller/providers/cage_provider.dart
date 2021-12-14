import 'package:birdy_app/model/cage_model.dart';
import 'package:flutter/material.dart';
class CageProvider extends ChangeNotifier{
  List<Cage> _cages=[Cage(id: '1', cageName: 'cage 1'),Cage(id: '2', cageName: 'cage 2',birdNumbers: 3),Cage(id: '3', cageName: 'cage 3',birdNumbers: 8),];

  List<Cage> get cages{
    return [..._cages];
  }

  void addCage( String name){
    final newCage= Cage(id:  DateTime.now().toString(), cageName: name);
    _cages.add(newCage);
    notifyListeners();
  }

  editCage(String id, String newname){
      final cageindex = _cages.indexWhere((cage) => cage.id == id);
      if(newname==''){
        return true;
      }
      if(cageindex >= 0){
        _cages[cageindex] = Cage(id: id, cageName: newname);
        notifyListeners();
      }else{
        print('there is a mistake');
      }
  }

 void deleteCage(String id) {
    _cages.removeWhere((cage) => cage.id==id);
    notifyListeners();
 }
}