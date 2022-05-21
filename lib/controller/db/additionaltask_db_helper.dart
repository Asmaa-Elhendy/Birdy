import 'package:birdy_app/model/additional_task_model.dart';
import 'package:birdy_app/controller/db/cages_database.dart';

class AdditionalTask_db_Helper{

  Future<AdditionalTask_model> create(AdditionalTask_model additionalTask) async {
    final db = await CagesDatabase.instance.database;
    final id = await db.insert(tableAdditionalTasks, additionalTask.toJson());
    print("here is add task${additionalTask.cageName}");
    return additionalTask.copy(id: id);
  }

   Future<List<AdditionalTask_model>> readAllTasks() async {
    final db = await CagesDatabase.instance.database;
    final result = await db.query(tableAdditionalTasks);
    return result.map((json) => AdditionalTask_model.fromJson(json)).toList();

  }


  Future<int> update(AdditionalTask_model additionalTask) async {
    final db = await CagesDatabase.instance.database;

    return db.update(
      tableAdditionalTasks,
      additionalTask.toJson(),
      where: '${AdditionaTasksFields.id} = ?',
      whereArgs: [additionalTask.id],
    );
  }
  Future<AdditionalTask_model> readTask(int id) async {
    final db = await CagesDatabase.instance.database;
    final maps = await db.query(
      tableAdditionalTasks,
      columns: AdditionaTasksFields.values,
      where: '${AdditionaTasksFields.id} = ?',
      whereArgs: [id],

    );


    if (maps.isNotEmpty) {
      //notifyListeners();
      return AdditionalTask_model.fromJson(maps.first); //convert back fron json
    } else {
      //notifyListeners();
      throw Exception('ID $id not found');
    }


  }
  Future<int> delete(int id) async {
    final db = await CagesDatabase.instance.database;
    print("delete calledd with$id");
    //notifyListeners();

    return await db.delete(
      tableAdditionalTasks,
      where: '${AdditionaTasksFields.id} = ?',
      whereArgs: [id],
    );
  }
  Future<List<AdditionalTask_model>> readTaskByCageId(int id) async {
    final db = await CagesDatabase.instance.database;

    final result = await db.query(
      tableAdditionalTasks,
      columns: AdditionaTasksFields.values,
      //retrieve column
      where: '${AdditionaTasksFields.cageId} = ?',
      // define which column  //num of ? depend oon num of check query
      whereArgs: [id],

    );
    return result.map((json) => AdditionalTask_model.fromJson(json))
        .toList(); //convert back fron json
  }


}