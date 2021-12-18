import 'package:birdy_app/model/dailytasks_model.dart';
import 'package:flutter/material.dart';

class DailyTasksProvider with ChangeNotifier{
  List<DailyTasks_model> _dailyTasks =[
    DailyTasks_model(
      id: "1",
        taskName: "feed",
        description: "you have to feed zezo bird ",
        place: "room1, cage2",
        ),
    DailyTasks_model(
      id: "2",
        taskName: "cleaning ",
        description: "you have to clean coco's cage",
        place: "room3, cage1",
        ),
    DailyTasks_model(
      id: "3",
        taskName: "water",
        description: "you have to watering zezo bird",
        place: "room2, cage2",
        ),
    DailyTasks_model(
      id: "4",
      taskName: "water",
      description: "you have to watering zezo bird",
      place: "room2, cage2",
    ),
    DailyTasks_model(
      id: "5",
      taskName: "water",
      description: "you have to watering zezo bird",
      place: "room2, cage2",
    ),
    DailyTasks_model(
      id: "6",
      taskName: "water",
      description: "you have to watering zezo bird",
      place: "room2, cage2",
    ),
    DailyTasks_model(
      id: "7",
      taskName: "water",
      description: "you have to watering zezo bird",
      place: "room2, cage2",
    ),
  ];

  List <DailyTasks_model> get dailyTasks{
    return [..._dailyTasks];  //copy list
  }
  List<DailyTasks_model> get notdoneTaks{
    return _dailyTasks.where((notdoneitem) => !notdoneitem.isDone).toList();
  }

  List<DailyTasks_model> get doneTasks{
    return _dailyTasks.where((doneitem) => doneitem.isDone).toList();
  }
  void makeTaskDone(String id){
    final task = _dailyTasks.indexWhere((item) => item.id == id);
    _dailyTasks[task].isDone = ! _dailyTasks[task].isDone;
    notifyListeners();



  }






}

