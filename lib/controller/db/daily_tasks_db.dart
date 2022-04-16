
// for check done of task of today

import 'package:birdy_app/model/new_daily_task_model.dart';

import '../room_db_connection.dart';

String table_name='daily_tasks';

class DailyTaskDB{




 static add_doneDailyTask(NewDailyTask newDailyTask,int day,int month,int year)async{

   final db= await DatabaseConnection.setRoomDatabase();

   NewDailyTaskDbModel newDailyTaskDbModel=NewDailyTaskDbModel(taskName: newDailyTask.taskName,roomId: newDailyTask.roomId, roomName: newDailyTask.roomName, cageId: newDailyTask.cageId, cageName: newDailyTask.cageName,day: day,month: month,year: year);

    var id=  await db.insert(table_name, newDailyTaskDbModel.Daily_task_to_map());
    return id;
    }

static deleteitem(NewDailyTaskDbModel newDailyTaskDbModel)async{
  final db= await DatabaseConnection.setRoomDatabase();
 var count= await db.rawDelete('DELETE FROM $table_name WHERE id = ?',[newDailyTaskDbModel.id],);
 return count;
}


static  getDailyTasks()async{
  final db= await DatabaseConnection.setRoomDatabase();

  return  db.query(table_name);

}





}