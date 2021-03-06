import 'package:birdy_app/model/rooms_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConnection{

 static Future<Database> setRoomDatabase()async{
    var directory=await getDatabasesPath();
     String path=join(directory,'room.db');  
     var database= await openDatabase(path,version: 1,onCreate: _oncreate);
     return database;

  }

 static _oncreate(Database database,int version)async{
   await database.execute("CREATE TABLE rooms(id INTEGER PRIMARY KEY AUTOINCREMENT,roomName TEXT,cagesCount INTEGER)");
   await database.execute("CREATE TABLE daily_tasks(id INTEGER PRIMARY KEY AUTOINCREMENT,taskName TEXT,roomId INTEGER,roomName TEXT,cageId INTEGER,cageName TEXT,isdone INTEGER,day INTEGER,month INTEGER,year INTEGER)");
   
 }

 static addRoom(Rooms_Model room)async {
   final db =await setRoomDatabase();
   final int id=await db.insert('rooms', room.room_to_map()); //تلقائي بيبقي فيه id

   return id;
 }
Future editroom(Rooms_Model room,String newName)async{
  final db=await setRoomDatabase();
  int count = await db.rawUpdate(
      'UPDATE rooms SET roomName = ? WHERE id = ?',
      ['$newName','${room.id}']);
  return count;
}
 Future deleteroom(int id)async{
   final db=await setRoomDatabase();
   var count = await db
       .rawDelete('DELETE FROM rooms WHERE id ="$id"');
   return count;

 }
 static Future<List<Map<String,dynamic>>>getRoomDatabase()async{
   final db=await setRoomDatabase();

   return db.query('rooms');
 }


 Future close() async {
   final db = await DatabaseConnection.setRoomDatabase();

   db.close();
 }

}