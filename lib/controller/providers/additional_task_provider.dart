import 'package:birdy_app/controller/db/additionaltask_db_helper.dart';
import 'package:birdy_app/model/additional_task_model.dart';
import 'package:flutter/cupertino.dart';

class AdditionalTaskProvider extends ChangeNotifier{

  List<AdditionalTask_model> _additionalTasks=[];
  List<AdditionalTask_model> _needTasks=[];

  List<AdditionalTask_model> get additionalTaskes{
    return [..._additionalTasks];
  }
  List<AdditionalTask_model> get needTasks{
    return [..._needTasks];
  }


  Future addAdditionalTask(String name,int cageId,int roomId,String cageName, String roomName, String appointment, bool isDone ) async{
    final newAdditionalTask = AdditionalTask_model(taskName: name, roomName: roomName, cageName: cageName, cageId: cageId, roomId: roomId, appointment: appointment);
    await AdditionalTask_db_Helper().create(newAdditionalTask);
    notifyListeners();
  }

  Future readAllTasks ()async {

    List<AdditionalTask_model> alltasks = await AdditionalTask_db_Helper().readAllTasks();
    _additionalTasks = alltasks;
    notifyListeners();
  }

  Future<AdditionalTask_model> getAdditionalTask(id) async{
    AdditionalTask_model cage = await AdditionalTask_db_Helper().readTask(id);
    return cage;

  }

  Future<List<AdditionalTask_model>> readTaskByCageId(id) async{
    List<AdditionalTask_model> need =await  AdditionalTask_db_Helper().readTaskByCageId(id);
    _needTasks = need;
    notifyListeners();
    return need;
  }

  editTask(AdditionalTask_model additionalTask) async{
    final newAdditionalTask = additionalTask.copy(
      roomId: additionalTask.roomId,
      cageId: additionalTask.cageId,
      appointment: additionalTask.appointment,
      cageName: additionalTask.cageName,
      roomName: additionalTask.roomName,
      taskName: additionalTask.taskName,
      isDone: additionalTask.isDone,
    );
    await AdditionalTask_db_Helper().update(newAdditionalTask);
    notifyListeners();
  }
  deleteTask(int id) async{
    await AdditionalTask_db_Helper().delete(id);
    notifyListeners();
  }

}