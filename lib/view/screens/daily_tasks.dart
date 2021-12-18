import 'package:birdy_app/model/dailytasks_model.dart';
import 'package:birdy_app/view/widgets/daily_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:birdy_app/view/widgets/daily_tasks_card.dart';
import 'package:birdy_app/controller/providers/dailytasks_provider.dart';



class DailyTasks extends StatefulWidget {
  const DailyTasks({Key? key}) : super(key: key);

  @override
  _DailyTasksState createState() => _DailyTasksState();
}

class _DailyTasksState extends State<DailyTasks> {

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
    List<DailyTasks_model> dailyTasks =dailyTasks_provider.notdoneTaks;
    List<DailyTasks_model> doneTasks =dailyTasks_provider.doneTasks;


    Widget getDailyTasks_widget( )
    {
      return Column(children:  dailyTasks.map((item) => DailyTasksCard(id: item.id,taskName: item.taskName,description: item.description,place: item.place,isdone: item.isDone,)).toList());
    }
    Widget getDoneTasks_widget( )
    {
      return Column(children:  doneTasks.map((item) => DailyTasksCard(id: item.id,taskName: item.taskName,description: item.description,place: item.place,isdone: item.isDone,)).toList());
    }

      return Scaffold(
        body: ListView(
          padding: EdgeInsets.only(
              top: height * 0.08, left: width * 0.03, right: width * 0.03),
          children: [
            DailyDate(),
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
}
