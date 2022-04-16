
class NewDailyTask{
  String taskName;
  List<String> daysList;
  int roomId;
  String roomName;
  int cageId;
  String cageName;
  bool isdone;

  NewDailyTask({required this.taskName,required this.daysList,required this.roomId,required this.roomName,required this.cageId,required this.cageName,this.isdone=false});

}
class NewDailyTaskDbModel{
  int id;
  String taskName;
  int roomId;
  String roomName;
  int cageId;
  String cageName;
  int isdone;
  int? day;
  int? month;
  int? year;

  NewDailyTaskDbModel({this.id=0,required this.taskName,required this.roomId,required this.roomName,required this.cageId,required this.cageName,this.isdone=0,required this.day,required this.month,required this.year});
  factory NewDailyTaskDbModel.fromJson(json){
    return NewDailyTaskDbModel(
      id: json['id'],
        taskName: json['taskName'],
        roomId: json['roomId'],
        roomName: json['roomName'],
        cageId: json['cageId'],
        cageName: json['cageName'],
       isdone: json['isdone'],
      day: json['day'],
      month: json['month'],
      year: json['year']
    );

  }
  Map<String,dynamic> Daily_task_to_map(){
    Map<String,dynamic> mapping = Map<String,dynamic>();
    mapping['taskName']=taskName;
    mapping['roomId']=roomId;
    mapping['roomName']=roomName;
    mapping['cageId']=cageId;
    mapping['cageName']=cageName;
    mapping['isdone']=isdone;
    mapping['day']=day;
    mapping['month']=month;
    mapping['year']=year;

    return mapping;

  }
}
