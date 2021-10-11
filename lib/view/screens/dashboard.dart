import 'package:birdy_app/view/screens/primary.dart';
import 'package:birdy_app/view/screens/profile.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  static  const dashboardid='id';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selected_index=0;

  final List<Widget> _children = [
    PrimaryPage(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor:Color(0xfff79281) ,
      currentIndex: selected_index,
        onTap: _onTap,
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,),
            label: 'Home',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded,),
            label: 'profile',
          ),
        ],

      ),
      body: _children[selected_index]
    );
  }

  _onTap(int index) {
  setState(() {
    selected_index=index;
  });
  }
}
