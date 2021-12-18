class DailyTasks_model{
  String id;
  String taskName;
  String description;
  String place;
  bool isDone;

  DailyTasks_model({required this.id,required this.taskName, required this.description,required this.place,  this.isDone = false});
}
