import 'package:birdy_app/controller/db/cages_database.dart';
import 'package:birdy_app/model/cage_model.dart';
import 'package:birdy_app/model/new_daily_task_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class DailyTaskController extends ChangeNotifier {
  List<Cage> all_cages = [];
  List<NewDailyTask> displayedclean = [];
  List<NewDailyTask> displayedfeed = [];
  List<NewDailyTask> displayedwatering = [];
// هشتغل عليهم
  List<NewDailyTask> displayedclean_new = [];
  List<NewDailyTask> displayedfeed_new = [];
  List<NewDailyTask> displayedwatering_new = [];
  List<Cage> get allCages{
    return [...all_cages];  //copy list
  }
  List<NewDailyTask> get getdisplayedclean{
    return [...displayedclean];  //copy list
  }
  List<NewDailyTask> get getdisplayedfeed{
    return [...displayedfeed];  //copy list
  }
  List<NewDailyTask> get getdisplayedwater{
    return [...displayedwatering];  //copy list
  }

  getall_cagesfunction() async {
    all_cages = await CagesDatabase.instance.readAllCages();
    notifyListeners();
  }

  gettodaytasks(List<Cage> allCages, String roomName, String day_today) async {
    //1

    List<NewDailyTask> cleaning_days_list = [];
    List<NewDailyTask> feeding_days_list = [];
    List<NewDailyTask> watering_days_list = [];
//2 شغلي ع روم واحده
    var list = [for(var i in allCages) if(i.roomName==roomName) i];

    for (int i = 0; i < list.length; i++) {
      cleaning_days_list.add(NewDailyTask(taskName: 'cleaning',
          daysList: list[i].cleaningDays.split(' ').toList(),
          roomId: list[i].room_id,
          roomName: list[i].roomName,
          cageId: list[i].id!,
          cageName: list[i].cageName));
      feeding_days_list.add(NewDailyTask(taskName: 'feeding',
          daysList: list[i].feedingDays.split(' ').toList(),
          roomId: list[i].room_id,
          roomName: list[i].roomName,
          cageId: list[i].id!,
          cageName: list[i].cageName));
      watering_days_list.add(NewDailyTask(taskName: 'watering',
          daysList: list[i].wateringDays.split(' ').toList(),
          roomId: list[i].room_id,
          roomName: list[i].roomName,
          cageId: list[i].id!,
          cageName: list[i].cageName));

      print(list[i].cageName);
    } //Monday tuesday wednesday thursday saturday sunday

    print('cleaning tasks $cleaning_days_list');
    for (var i in cleaning_days_list) {
      for (var j in i.daysList) {
        if (j == day_today) {
          displayedclean.add(i);
        }
      }
    }
    print('displayed cleaning $displayedclean');


    for (var i in feeding_days_list) {
      for (var j in i.daysList) {
        if (j == day_today) {
          displayedfeed.add(i);
        }
      }
    }
    print('displayed feeding $displayedfeed');


    for (var i in watering_days_list) {
      for (var j in i.daysList) {
        if (j == day_today) {
          displayedwatering.add(i);
        }
      }
    }
    displayedclean_new=displayedclean;
    displayedfeed_new=displayedfeed;
    displayedwatering_new=displayedwatering;
    displayedclean=[];
    displayedfeed=[];
    displayedwatering=[];
    print('displayed watering $displayedwatering');
    //3


    print('asmaa all cages $allCages');
    notifyListeners();
  }


getnew(allcagesprovider,String today){
    List<NewDailyTask> cleaning_days_list = [];
    List<NewDailyTask> feeding_days_list = [];
    List<NewDailyTask> watering_days_list = [];

    for(var i in allcagesprovider){
    i.cleaningDays==''?print(''): cleaning_days_list.add(NewDailyTask(taskName: 'cleaning', daysList: i.cleaningDays.split(" ").toList(), roomId: i.room_id, roomName: i.roomName, cageId: i.id!, cageName: i.cageName));
     i.feedingDays==''?print(''): feeding_days_list.add(NewDailyTask(taskName: 'feeding', daysList: i.feedingDays.split(" ").toList(), roomId: i.room_id, roomName: i.roomName, cageId: i.id!, cageName: i.cageName));
      i.wateringDays==''?print(''):watering_days_list.add(NewDailyTask(taskName: 'watering', daysList: i.wateringDays.split(" ").toList(), roomId: i.room_id, roomName: i.roomName, cageId: i.id!, cageName: i.cageName));
    }
    print('cleaning  $cleaning_days_list');
    print('cleaning  ${cleaning_days_list.first.cageName}');
    print('feeding $feeding_days_list');
    print('watering $watering_days_list');


    for(var i in cleaning_days_list){
      print(i.daysList);
       for(var j in i.daysList){
         if(today==j){
           print('equal');
           displayedclean.add(i);
         }
         // else{
         //   day='';
         // }
       }

    }
    for(var i in feeding_days_list){
      print(i.daysList);
      for(var j in i.daysList){
        if(today==j){
          print('equal');
          displayedfeed.add(i);
        }
        // else{
        //   day='';
        // }
      }

    }
    for(var i in watering_days_list){
      print(i.daysList);
      for(var j in i.daysList){
        if(today==j){
          print('equal');
          displayedwatering.add(i);
        }
        // else{
        //   day='';
        // }
      }

    }
    displayedclean_new=displayedclean;
    displayedfeed_new=displayedfeed;
    displayedwatering_new=displayedwatering;
    displayedclean=[];
    displayedfeed=[];
    displayedwatering=[];
    print('new displayed clean$displayedclean_new');
    print('new displayed feed$displayedfeed_new');
    print('new displayed water$displayedwatering_new');

    notifyListeners();
}


}