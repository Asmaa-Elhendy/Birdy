import 'package:birdy_app/model/bird_model.dart';
import 'package:birdy_app/model/cage_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class CagesDatabase {
  static final CagesDatabase instance = CagesDatabase._init();

  static Database? _database;

  CagesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cages.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 5, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // await db.execute(
    //     "CREATE TABLE Cages(id INTEGER PRIMARY KEY, cageName TEXT, birdNumbers INTEGER, room_id INTEGER,cleaningDays TEXT,feedingDays TEXT,wateringDays TEXT)");
    // print("Created tables");
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final integerType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableCages (
  ${CagesFields.id} $idType,
  ${CagesFields.room_id} $integerType,
  ${CagesFields.cageName} $textType,
  ${CagesFields.birdNumbers} $integerType,
  ${CagesFields.cleaningDays} $textType,
  ${CagesFields.feedingDays} $textType,
  ${CagesFields.wateringDays} $textType,
  ${CagesFields.roomName} $textType

  )
''');



  await db.execute(
        "CREATE TABLE birds(_id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,type TEXT,color TEXT,ringNum INTEGER,age INTEGER,image BLOB,ringType TEXT,gender TEXT,breed TEXT,roomId INTEGER,cageId INTEGER,roomName TEXT,cageName TEXT)");

    await db.execute(
        "CREATE TABLE AdditionalTasks(_id INTEGER PRIMARY KEY AUTOINCREMENT,taskName TEXT,roomName TEXT,cageName TEXT,cageId INTEGER,roomId INTEGER,appointment TEXT, isDone BOOLEAN NOT NULL)");
  }


  Future<Cage> create(Cage cage) async {
    final db = await instance.database;
    final id = await db.insert(tableCages, cage.toJson());
    print("id creet${cage.id}");
    print("cage createdddddd");

    return cage.copy(id: id);
  }

  Future<Cage> readCage(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableCages,
      columns: CagesFields.values,
      //retrieve column
      where: '${CagesFields.id} = ?',
      // define which column  //num of ? depend oon num of check query
      whereArgs: [id],

    );


    if (maps.isNotEmpty) {
      //notifyListeners();
      return Cage.fromJson(maps.first); //convert back fron json
    } else {
      //notifyListeners();
      throw Exception('ID $id not found');
    }
  }

  Future<List<Cage>> readAllCages() async {
    final db = await instance.database;

    final orderBy = '${CagesFields.cageName} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableCages);
    //notifyListeners();

    return result.map((json) => Cage.fromJson(json)).toList();
  }
  Future<List<Cage>> readCageByRoomId(int id) async {
    final db = await instance.database;

    final result = await db.query(
      tableCages,
      columns: CagesFields.values,
      //retrieve column
      where: '${CagesFields.room_id} = ?',
      // define which column  //num of ? depend oon num of check query
      whereArgs: [id],

    );
    return result.map((json) => Cage.fromJson(json))
        .toList();


  }




  Future<int> update(Cage cage) async {
    final db = await instance.database;

    return db.update(
      tableCages,
      cage.toJson(),
      where: '${CagesFields.id} = ?',
      whereArgs: [cage.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    print("delete calledd with$id");
    //notifyListeners();

    return await db.delete(
      tableCages,
      where: '${CagesFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<Bird> createBird(Bird bird) async {
    final db = await instance.database;
    final id = await db.insert(tableBirds, bird.toJson());
    print("bird add in db");
    return bird.copy(id: id);
  }

  Future<List<Bird>> readAllBirds() async {
    final db = await instance.database;

    final orderBy = '${BirdsFields.cageName} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableBirds);
    //notifyListeners();

    return result.map((json) => Bird.fromJson(json)).toList();
  }

  Future<List<Bird>> readBirdByCageId(int id) async {
    //read cage by room id
    final db = await instance.database;

    final result = await db.query(
      'Birds',
      columns: BirdsFields.values,
      //retrieve column
      where: '${BirdsFields.cageId} = ?',
      // define which column  //num of ? depend oon num of check query
      whereArgs: [id],

    );



      return result.map((json) => Bird.fromJson(json))
          .toList(); //convert back fron json
  }
  Future<int> deleteBird(int id) async {
    final db = await instance.database;
    print("delete calledd with$id");
    //notifyListeners();

    return await db.delete(
      tableBirds,
      where: '${BirdsFields.id} = ?',
      whereArgs: [id],
    );
  }






  Future close() async {
    final db = await instance.database;

    db.close();
  }
}