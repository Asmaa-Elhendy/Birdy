import 'dart:async';

import 'package:birdy_app/controller/providers/cage_provider.dart';
import 'package:birdy_app/controller/providers/new_daily_task_controller.dart';
import 'package:birdy_app/controller/providers/new_daily_task_controller_saved_to_db.dart';
import 'package:birdy_app/view/screens/primary.dart';
import 'package:birdy_app/view/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'daily_tasks.dart';
import 'package:intl/intl.dart';
class Dashboard extends StatefulWidget {
  static  const dashboardid='id';
  int selected_index;
  Dashboard({this.selected_index=0});


  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  final List<Widget> _children = [
    PrimaryPage(),
    DailyTasks(),
    UserProfile(),

  ];


  @override
  Widget build(BuildContext context) {
    CageProvider cageProvider =Provider.of<CageProvider>(context,listen: false);
    cageProvider.getcagesDatabase();


    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor:Color(0xfff79281) ,
      currentIndex: widget.selected_index,
        onTap: _onTap,
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,),
            label: 'Home',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Daily tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded,),
            label: 'profile',
          ),

        ],

      ),
      body: _children[widget.selected_index]
    );
  }

  _onTap(int index) async{
    if(index==1){
      DailyTaskControllerSavedToDB dailyTaskControllerSavedToDB=Provider.of<DailyTaskControllerSavedToDB>(context,listen: false);

      DailyTaskController dailyTaskControllerprovider=Provider.of<DailyTaskController>(context,listen: false);
      CageProvider cageProvider =Provider.of<CageProvider>(context,listen: false);

      dailyTaskControllerprovider.getnew(cageProvider.allcagesfortasks,'Wednesday');

      dailyTaskControllerSavedToDB.getdb();

      for(var i in dailyTaskControllerSavedToDB.saved_list){
        print(i.day==DateTime.now().day);
        if(i.day==DateTime.now().day&&i.month==DateTime.now().month&&i.year==DateTime.now().year){
          dailyTaskControllerprovider.displayedclean_new.removeWhere((element) => element.roomId==i.roomId&&element.cageId==i.cageId&&element.taskName==i.taskName);
          dailyTaskControllerprovider.displayedfeed_new.removeWhere((element) => element.roomId==i.roomId&&element.cageId==i.cageId&&element.taskName==i.taskName);
          dailyTaskControllerprovider.displayedwatering_new.removeWhere((element) => element.roomId==i.roomId&&element.cageId==i.cageId&&element.taskName==i.taskName);

        }
      }

    }
    setState(() {
      widget. selected_index=index;

    });


}
}