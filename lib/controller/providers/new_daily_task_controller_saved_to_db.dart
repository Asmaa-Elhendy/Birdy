

import 'package:birdy_app/controller/db/daily_tasks_db.dart';
import 'package:flutter/material.dart';

import 'package:birdy_app/model/new_daily_task_model.dart';

class DailyTaskControllerSavedToDB extends ChangeNotifier {
  List<NewDailyTaskDbModel> today_saved_tasks = [];
  List <Map<String,dynamic>>today_list_map=[];


  List<NewDailyTaskDbModel> get saved_list{
    return [...today_saved_tasks];
  }
  adddoneTodayTask(NewDailyTask newDailyTask,int day,int month,int year){
    DailyTaskDB.add_doneDailyTask(newDailyTask,day,month,year);
    notifyListeners();
  }
delete(NewDailyTaskDbModel newDailyTaskDbModel){
    DailyTaskDB.deleteitem(newDailyTaskDbModel);
    notifyListeners();
}

  getdb()async{
    today_list_map= await DailyTaskDB.getDailyTasks();
    today_saved_tasks=today_list_map.map((json) => NewDailyTaskDbModel.fromJson(json)).toList() as List<NewDailyTaskDbModel>;
    notifyListeners();
  }
}