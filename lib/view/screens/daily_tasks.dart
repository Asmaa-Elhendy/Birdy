import 'package:birdy_app/controller/providers/cage_provider.dart';
import 'package:birdy_app/controller/providers/rooms_provider.dart';
import 'package:birdy_app/model/additional_task_model.dart';
import 'package:birdy_app/model/cage_model.dart';
import 'package:birdy_app/model/dailytasks_model.dart';
import 'package:birdy_app/model/rooms_model.dart';
import 'package:birdy_app/view/widgets/daily_date.dart';
import 'package:birdy_app/view/widgets/dropboxAddBird.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:birdy_app/view/widgets/daily_tasks_card.dart';
import 'package:birdy_app/controller/providers/dailytasks_provider.dart';



class DailyTasks extends StatefulWidget {
  static ValueNotifier<List<AdditionalTask_model>> additionalTasks=ValueNotifier([]);
  const DailyTasks({Key? key}) : super(key: key);

  @override
  _DailyTasksState createState() => _DailyTasksState();
}

class _DailyTasksState extends State<DailyTasks> {
  List<AdditionalTask_model> addTaks = DailyTasks.additionalTasks.value;
  List<dynamic> _items = ["All"];
  dynamic selectValueRooms  = "All";
  var selectValueCages;



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    DailyTasksProvider dailyTasks_provider = Provider.of<DailyTasksProvider>(context);
    CageProvider cages_provider =Provider.of<CageProvider>(context);

    List<DailyTasks_model> dailyTasks =dailyTasks_provider.notdoneTaks;
    List<DailyTasks_model> doneTasks =dailyTasks_provider.doneTasks;


    Rooms_Provider rooms_provider = Provider.of<Rooms_Provider>(context);
     // getitems(){
     //   rooms_provider.rooms.map((room) =>room.name).toList();
     // }

    List _rooms = rooms_provider.rooms.map((room) =>room.roomName).toList();

    List allItems =List.from(_items)..addAll(_rooms);






    Widget getDailyTasks_widget( )
    {
      return Column(children:  dailyTasks.map((item) => DailyTasksCard(id: item.id,taskName: item.taskName,place: item.place,isdone: item.isDone,)).toList());
    }
    Widget getDoneTasks_widget( )
    {
      return Column(children:  doneTasks.map((item) => DailyTasksCard(id: item.id,taskName: item.taskName,place: item.place,isdone: item.isDone,)).toList());
    }
    Widget getAdditionaltasks_widget( )
    {
      // return ValueListenableBuilder(valueListenable: DailyTasks.additionalTasks,
      //     builder: ( context,List newValue,Widget child){
      //   return Column(children: newValue.map((item) => DailyTasksCard(id: item.id,taskName: item.taskName,description: item.description,place: item.place,isdone: item.isDone,)).toList());;
      //     }
      // );
     return Column(children:  addTaks.map((item) => DailyTasksCard(id: item.id,taskName: item.taskName,place: "${item.room},${item.cage}",isdone: item.isDone,)).toList());
    }

      return Scaffold(
        body: ListView(
          padding: EdgeInsets.only(
              top: height * 0.08, left: width * 0.03, right: width * 0.03),
          children: [
            DailyDate(),
            //filter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: DropdownButton(
                    style: TextStyle(color: Colors.grey[600],
                    ),
                    value:selectValueRooms,
                    //isDense: true,
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                    focusColor: Theme.of(context).primaryColor,
                    items: allItems.map(( value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectValueRooms = newValue! ;

                      });
                      print(selectValueRooms);
                    },
                  ),
                ),
               selectValueRooms=="All"?Container(): DropdownButton<Cage>(
                  hint: Text("Select Cage"),
                  style: TextStyle(color: Colors.grey[600],),
                  underline: Container(
                    height: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                  value: selectValueCages,
                  onChanged: (  cage) {
                    setState(() {
                      this.selectValueCages = cage! ;
                    });
                  },
                  items: cages_provider.cages.map((Cage cage) {
                    return  DropdownMenuItem(
                      value: cage,
                      child: Row(
                        children: <Widget>[
                          Text( cage.cageName,
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                ),
              ],
            ),
            SizedBox(height: height * 0.035,),
            Text("Daily Tasks",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            getDailyTasks_widget(),
            SizedBox(height: height * 0.02,),

            Text("Additional Tasks",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            getAdditionaltasks_widget(),
            SizedBox(height: height * 0.02,),

            Text("Done Tasks",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),),
            getDoneTasks_widget()




          ],
        ),
      );
      // return Scaffold(
      //   body: Padding(
      //     padding: EdgeInsets.only(top: height * 0.25, left: width * 0.03, right: width * 0.03),
      //     child: Column(
      //      crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text("Daily Tasks",
      //           textAlign: TextAlign.left,
      //           style: TextStyle(
      //             color: Colors.black,
      //             fontWeight: FontWeight.bold,
      //             fontSize: 20
      //           ),
      //         ),
      //         Expanded(
      //           child: ListView.builder(
      //             itemCount: dailyTasks_provider.dailyTasks.length,
      //             itemBuilder: (context, int index){
      //
      //               return DailyTasksCard(
      //                 taskName: dailyTasks_provider.dailyTasks[index].taskName,
      //                 description: dailyTasks_provider.dailyTasks[index].description,
      //                 place: dailyTasks_provider.dailyTasks[index].place,
      //               );
      //             },
      //               ),
      //         ),
      //         Text("Done Tasks",
      //           textAlign: TextAlign.left,
      //           style: TextStyle(
      //               color: Colors.black,
      //               fontWeight: FontWeight.bold,
      //               fontSize: 20
      //           ),
      //         ),
      //         Expanded(
      //           child: ListView.builder(
      //             itemCount: dailyTasks_provider.dailyTasks.length,
      //             itemBuilder: (context, int index){
      //               return DailyTasksCard(
      //                 taskName: dailyTasks_provider.dailyTasks[index].taskName,
      //                 description: dailyTasks_provider.dailyTasks[index].description,
      //                 place: dailyTasks_provider.dailyTasks[index].place,
      //               );
      //             },
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // );



  }
  // Widget _drobbx(){
  //   var selectedUser;
  //   return Container(
  //       padding: EdgeInsets.only(
  //           left: MediaQuery.of(context).size.width * 0.11
  //       ),
  //       width: MediaQuery.of(context).size.width * 0.4,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(15),
  //         border: Border.all(color: Theme.of(context).primaryColor),
  //         //color: Theme.of(context).primaryColor
  //         color: Color(0xfff79281).withOpacity(0.3),
  //       ),
  //       child:  DropdownButton<Rooms_Model>(
  //         hint:  Text("Select Room",style: TextStyle(color:Color(0xfff79281),fontWeight: FontWeight.bold),),
  //         value: selectedUser,
  //         onChanged: (  room) {
  //           setState(() {
  //             this.selectedUser = room! ;
  //             print(room.name);
  //             selectedRoomName=room.name;
  //
  //
  //           });
  //         },
  //         // style: TextStyle(color:Color(0xfff79281) ),
  //         items: rooms_provider.rooms.map((Rooms_Model room) {
  //           return  DropdownMenuItem(
  //             value: room,
  //             child: Row(
  //               children: <Widget>[
  //                 Text( room.name),
  //
  //               ],
  //             ),
  //           );
  //         }).toList(),
  //       ),
  //   );
  //
  // }
}
