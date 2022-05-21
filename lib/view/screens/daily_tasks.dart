import 'package:birdy_app/controller/providers/new_daily_task_controller.dart';
import 'package:birdy_app/controller/providers/cage_provider.dart';
import 'package:birdy_app/controller/providers/new_daily_task_controller_saved_to_db.dart';
import 'package:birdy_app/controller/providers/rooms_provider.dart';
import 'package:birdy_app/model/additional_task_model.dart';
import 'package:birdy_app/model/cage_model.dart';
import 'package:birdy_app/model/dailytasks_model.dart';
import 'package:birdy_app/view/widgets/new_card_task.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:birdy_app/controller/providers/dailytasks_provider.dart';
import 'package:intl/intl.dart';

class DailyTasks extends StatefulWidget {
  static ValueNotifier<List<AdditionalTask_model>> additionalTasks=ValueNotifier([]);
  const DailyTasks({Key? key}) : super(key: key);

  @override
  _DailyTasksState createState() => _DailyTasksState();
}

class _DailyTasksState extends State<DailyTasks> with WidgetsBindingObserver {
  List<AdditionalTask_model> addTaks = DailyTasks.additionalTasks.value;
  List<dynamic> _items = ["All"];
  dynamic selectValueRooms  = "All";
  var selectValueCages;
  DateTime today=DateTime.now();
  DateTime selectd_date_time=DateTime.now();
  String today_day='';
  List<Cage> allcages=[];

@override

  void initState() {
    // TODO: implement initState
    super.initState();
    today_day=DateFormat('EEEE').format(today);
    print('today $today_day');

  //  WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      DailyTaskControllerSavedToDB dailyTaskControllerSavedToDB=Provider.of<DailyTaskControllerSavedToDB>(context,listen: false);

      for(var i in dailyTaskControllerSavedToDB.saved_list){
        print(i.day);
        if(i.day==DateTime.now().day&&i.month==DateTime.now().month&&i.year==DateTime.now().year){
          return;
        }else{
          dailyTaskControllerSavedToDB.delete(i);
          dailyTaskControllerSavedToDB.getdb();
        }}
   //   CageProvider cageProvider =Provider.of<CageProvider>(context,listen: false);
     // DailyTaskController dailyTaskControllerprovider=Provider.of<DailyTaskController>(context,listen: false);

  //    print(dailyTaskControllerprovider.allCages);
   //   WidgetsBinding.instance!.addObserver(this);

      // dailyTaskControllerprovider.getnew(cageProvider.allcagesfortasks,today_day);
      //
      // dailyTaskControllerSavedToDB.getdb();
      // for(var i in dailyTaskControllerSavedToDB.saved_list){
      //   print(i.day==DateTime.now().day);
      //   if(i.day==DateTime.now().day&&i.month==DateTime.now().month&&i.year==DateTime.now().year){
      //     dailyTaskControllerprovider.displayedclean_new.removeWhere((element) => element.roomId==i.roomId&&element.cageId==i.cageId&&element.taskName==i.taskName);
      //     dailyTaskControllerprovider.displayedfeed_new.removeWhere((element) => element.roomId==i.roomId&&element.cageId==i.cageId&&element.taskName==i.taskName);
      //     dailyTaskControllerprovider.displayedwatering_new.removeWhere((element) => element.roomId==i.roomId&&element.cageId==i.cageId&&element.taskName==i.taskName);
      //
      //   }
      //
      // }taskName

  //  });


  }

  @override
  Widget build(BuildContext context) {
    DailyTaskController dailyTaskControllerprovider=Provider.of<DailyTaskController>(context);




    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    var _selectedValue;

    DailyTasksProvider dailyTasks_provider = Provider.of<DailyTasksProvider>(context);
    CageProvider cages_provider =Provider.of<CageProvider>(context);

    List<DailyTasks_model> dailyTasks =dailyTasks_provider.notdoneTaks;
    List<DailyTasks_model> doneTasks =dailyTasks_provider.doneTasks;
    DailyTaskControllerSavedToDB dailyTaskControllerSavedToDB=Provider.of<DailyTaskControllerSavedToDB>(context);

    Rooms_Provider rooms_provider = Provider.of<Rooms_Provider>(context);
     // getitems(){
     //   rooms_provider.rooms.map((room) =>room.name).toList();
     // }

    List _rooms = rooms_provider.rooms.map((room) =>room.roomName).toList();

    List allItems =List.from(_items)..addAll(_rooms);






    // Widget getDailyTasks_widget( )
    // {
    //   return Column(children:  dailyTasks.map((item) => DailyTasksCard(id: item.id,taskName: item.taskName,cagestoday_tasks: [],place: item.place,isdone: item.isDone,)).toList());
    // }
    // Widget getDoneTasks_widget( )
    // {
    //   return Column(children:  doneTasks.map((item) => DailyTasksCard(id: item.id,taskName: item.taskName,cagestoday_tasks:[],place: item.place,isdone: item.isDone,)).toList());
    // }
    // Widget getAdditionaltasks_widget( )
    // {
    //   // return ValueListenableBuilder(valueListenable: DailyTasks.additionalTasks,
    //   //     builder: ( context,List newValue,Widget child){
    //   //   return Column(children: newValue.map((item) => DailyTasksCard(id: item.id,taskName: item.taskName,description: item.description,place: item.place,isdone: item.isDone,)).toList());;
    //   //     }
    //   // );
    //  return Column(children:  addTaks.map((item) => DailyTasksCard(id: item.id,taskName: item.taskName,cagestoday_tasks:[],place: "${item.room},${item.cage}",isdone: item.isDone,)).toList());
    // }

      return Scaffold(
        body: ListView(
          padding: EdgeInsets.only(
              top: height * 0.08, left: width * 0.03, right: width * 0.03),
          children: [
            Padding(
              padding:  EdgeInsets.all(height*.02),
              child:
              DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor:  Color(0xfff79281),
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  print(date.runtimeType);

                    print('date $date');
                   selectd_date_time=date;
                    print('today in date $today');
                  print(DateFormat('EEEE').format(date));
                    today_day=DateFormat('EEEE').format(date);
                    print('date change $today_day');
                    dailyTaskControllerprovider.getnew(cages_provider.allcagesfortasks, today_day);
                if(  selectd_date_time.day==DateTime.now().day&&selectd_date_time.month==DateTime.now().month&&selectd_date_time.year==DateTime.now().year){

                  for(var i in dailyTaskControllerSavedToDB.saved_list){
    if(i.day==DateTime.now().day&&i.month==DateTime.now().month&&i.year==DateTime.now().year) {
      dailyTaskControllerprovider.displayedclean_new.removeWhere((element) =>
      element.roomId == i.roomId && element.cageId == i.cageId &&
          element.taskName == i.taskName);
      dailyTaskControllerprovider.displayedfeed_new.removeWhere((element) =>
      element.roomId == i.roomId && element.cageId == i.cageId &&
          element.taskName == i.taskName);
      dailyTaskControllerprovider.displayedwatering_new.removeWhere((element) =>
      element.roomId == i.roomId && element.cageId == i.cageId &&
          element.taskName == i.taskName);
    } }}

                  // New date selected
                  // setState(() {
                  //   _selectedValue = date;
                  //
                  // });

                },
              ),


            ),
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
                      // setState(() {
                      //   selectValueRooms = newValue! ;
                      //
                      // });
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
                    // setState(() {
                    //   this.selectValueCages = cage! ;
                    // });
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
             ),Padding(
               padding:  EdgeInsets.symmetric(vertical: height*.01),
               child: Text('Cleaning',style: TextStyle(color: Color(0xfff79281),fontSize: width*.05),),
             ),
            Column(
              children: dailyTaskControllerprovider.displayedclean_new.length==0||dailyTaskControllerprovider.displayedclean_new==null?
             [ Center(child: Text('No cleaning tasks today'),)]:
              dailyTaskControllerprovider.displayedclean_new.map((clean_today_task) =>
             Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
    today.day==selectd_date_time.day&&today.month==selectd_date_time.month&&today.year==selectd_date_time.year? InkWell(
                   onTap: (){

                     setState(() {
                       clean_today_task.isdone=!clean_today_task.isdone;
                       print(clean_today_task.isdone);
                       if( clean_today_task.isdone==true){
                       //add to db +  display done tasks from db  +   delete from provider
    dailyTaskControllerprovider.displayedclean_new.removeWhere((element) => element.roomId==clean_today_task.roomId&&element.cageId==clean_today_task.cageId);
    dailyTaskControllerSavedToDB.adddoneTodayTask(clean_today_task,DateTime.now().day,DateTime.now().month,DateTime.now().year);

    dailyTaskControllerSavedToDB.getdb();
                         print('smsm ${dailyTaskControllerSavedToDB.saved_list}');
                       }
                     });

                   },
                   child: Container(
                     width: width*.065,
                     height: height*.03,
                     decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                       border: Border.all(color: Colors.black),
                     borderRadius: BorderRadius.all(Radius.circular(1.0))),
                     child: Center(child: clean_today_task.isdone?Icon(Icons.done,size: width*.05,):Text(''),),
                   ),
                 ):Container(),
                 NewCardTask(width: width, height: height,taskname:clean_today_task.taskName ,room_name: clean_today_task.roomName, cage_name: clean_today_task.cageName,done:false),
               ],
             )).toList()),//SizedBox(height: 100,
            Padding(
              padding:  EdgeInsets.symmetric(vertical: height*.01),
              child: Text('Feeding',style: TextStyle(color: Color(0xfff79281),fontSize: width*.05),),
            ),
            Column(
                children: dailyTaskControllerprovider.displayedfeed_new.length==0||dailyTaskControllerprovider.displayedfeed_new==null?
    [ Center(child: Text('No feeding tasks today'),)]:
    dailyTaskControllerprovider.displayedfeed_new.map((feed_today_task) =>
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
    today.day==selectd_date_time.day&&today.month==selectd_date_time.month&&today.year==selectd_date_time.year? GestureDetector(
                          onTap: (){
                            setState(() {
                              feed_today_task.isdone=!feed_today_task.isdone;
                              if( feed_today_task.isdone==true){
    //add to db +  display done tasks from db  +   delete from provider
    dailyTaskControllerprovider.displayedfeed_new.removeWhere((element) => element.roomId==feed_today_task.roomId&&element.cageId==feed_today_task.cageId);
    dailyTaskControllerSavedToDB.adddoneTodayTask(feed_today_task,DateTime.now().day,DateTime.now().month,DateTime.now().year);

    dailyTaskControllerSavedToDB.getdb();
    }
                            });
                          },
                          child: Container(
                            width: width*.06,
                            height: height*.03,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.all(Radius.circular(1.0))),
                            child: Center(child: feed_today_task.isdone?Icon(Icons.done,size: width*.05,):Text(''),),
                          ),
                        ):Container(),
                        NewCardTask(width: width, height: height,taskname:feed_today_task.taskName, room_name: feed_today_task.roomName, cage_name: feed_today_task.cageName,done:false),
                      ],
                    )).toList()),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: height*.01),
              child: Text('Watering',style: TextStyle(color: Color(0xfff79281),fontSize: width*.05),),
            ),
            Column(
                children:dailyTaskControllerprovider.displayedwatering_new.length==0||dailyTaskControllerprovider.displayedwatering_new==null?
    [ Center(child: Text('No watering tasks today'),)]:
    dailyTaskControllerprovider.displayedwatering_new.map((water_today_task) =>
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
    today.day==selectd_date_time.day&&today.month==selectd_date_time.month&&today.year==selectd_date_time.year? GestureDetector(
                          onTap: (){
                            setState(() {
                              water_today_task.isdone=!water_today_task.isdone;
                              if( water_today_task.isdone==true){
    //add to db +  display done tasks from db  +   delete from provider
    dailyTaskControllerprovider.displayedwatering_new.removeWhere((element) => element.roomId==water_today_task.roomId&&element.cageId==water_today_task.cageId);
    dailyTaskControllerSavedToDB.adddoneTodayTask(water_today_task,DateTime.now().day,DateTime.now().month,DateTime.now().year);

    dailyTaskControllerSavedToDB.getdb();
    print('smsm ${dailyTaskControllerSavedToDB.saved_list}');
    }
                            });
                          },
                          child: Container(
                            width: width*.06,
                            height: height*.03,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.all(Radius.circular(1.0))),
                            child: Center(child: water_today_task.isdone?Icon(Icons.done,size: width*.05,):Text(''),),
                          ),
                        ):Container(),
                        NewCardTask(width: width, height: height,taskname:water_today_task.taskName, room_name: water_today_task.roomName, cage_name: water_today_task.cageName,done:false),
                      ],
                    )).toList()),


    SizedBox(height: height * 0.02,),

            Text("Additional Tasks",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
         //   getAdditionaltasks_widget(),
            SizedBox(height: height * 0.02,),

      selectd_date_time.day==DateTime.now().day&&selectd_date_time.month==DateTime.now().month&&selectd_date_time.year==DateTime.now().year?
    Text("Done Tasks Today",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),):SizedBox(),
          //  getDoneTasks_widget()
    selectd_date_time.day==DateTime.now().day&&selectd_date_time.month==DateTime.now().month&&selectd_date_time.year==DateTime.now().year?Column(
    children: dailyTaskControllerSavedToDB.saved_list.length==0||dailyTaskControllerSavedToDB.saved_list.isEmpty?
    [ Center(child: Text('No done tasks today'),)]:
    dailyTaskControllerSavedToDB.saved_list.map((done_task_today) =>
    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    today.day==selectd_date_time.day&&today.month==selectd_date_time.month&&today.year==selectd_date_time.year? Container(
    width: width*.065,
    height: height*.03,
    decoration: BoxDecoration(
    shape: BoxShape.rectangle,
    color: Color(0xfff79281),
    border: Border.all(color: Colors.black),
    borderRadius: BorderRadius.all(Radius.circular(1.0))),
    child: Center(child:Icon(Icons.done,size: width*.05,color:Colors.white),),
    ):Container(),SizedBox(width:width*.02),
    Expanded(child: NewCardTask(width: width, height: height,taskname:done_task_today.taskName, room_name: done_task_today.roomName, cage_name: done_task_today.cageName,done:true)),
    ],
    )).toList()):SizedBox()




          ],
        ),
      );

  }


}
