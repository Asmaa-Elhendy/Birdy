final String tableAdditionalTasks= 'AdditionalTasks';

class AdditionaTasksFields{
  static final List<String> values = [
    id,taskName,roomName,cageName,cageId,roomId,appointment,isDone
  ];

  static final String id="_id";
  static final String taskName="taskName";
  static final String roomName ='roomName';
  static final String cageName="cageName";
  static final String cageId ="cageId";
  static final String roomId = "roomId";
  static final String appointment ="appointment";
  static  final String isDone = "isDone";

}


class AdditionalTask_model{
  int? id;
  String taskName;
  String roomName;
  String cageName;
  int cageId;
  int roomId;
  String appointment;
  bool isDone;


  AdditionalTask_model({ this.id,required this.taskName, required this.roomName,required this.cageName, required this.cageId,required this.roomId, this.isDone = false,required this.appointment});

  AdditionalTask_model copy({
     int? id,
    String? taskName,
    String? roomName,
    String? cageName,
    int? cageId,
    int? roomId,
    String? appointment,
    bool? isDone
  }) {
    return AdditionalTask_model(
        id: id ?? this.id,
        taskName: taskName??this.taskName,
        roomName: roomName??this.roomName,
        cageName: cageName??this.cageName,
    cageId: cageId??this.cageId,
        roomId: roomId??this.roomId,
        appointment: appointment??this.appointment,
      isDone: isDone??this.isDone
    );
  }
  Map<String, Object?> toJson() => {
    AdditionaTasksFields.id:id,
    AdditionaTasksFields.taskName:taskName,
    AdditionaTasksFields.roomName:roomName,
    AdditionaTasksFields.cageName:cageName,
    AdditionaTasksFields.cageId:cageId,
    AdditionaTasksFields.roomId:roomId,
    AdditionaTasksFields.appointment:appointment,
    AdditionaTasksFields.isDone:isDone ? 1 : 0,
  };

  static AdditionalTask_model fromJson(Map<String, Object?> json) => AdditionalTask_model(
    id: json[AdditionaTasksFields.id] as int?,
    cageId: json[AdditionaTasksFields.cageId] as int,
    roomId: json[AdditionaTasksFields.roomId] as int,
    taskName:json[AdditionaTasksFields.taskName]  as String,
    roomName: json[AdditionaTasksFields.roomName]  as String,
    cageName: json[AdditionaTasksFields.cageName]  as String,
    appointment: json[AdditionaTasksFields.appointment]  as String,
    isDone: json[AdditionaTasksFields.isDone] == 0,


  );


}
