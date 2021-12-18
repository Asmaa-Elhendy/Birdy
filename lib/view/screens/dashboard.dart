import 'package:birdy_app/view/screens/primary.dart';
import 'package:birdy_app/view/screens/profile.dart';
import 'package:flutter/material.dart';
import 'daily_tasks.dart';

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

  _onTap(int index) {
  setState(() {
   widget. selected_index=index;

  });
  }
}
