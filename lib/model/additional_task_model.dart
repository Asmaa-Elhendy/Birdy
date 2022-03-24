class AdditionalTask_model{
  String id;
  String taskName;
  String room;
  String cage;
  String appointment;
  bool isDone;

  AdditionalTask_model({required this.id,required this.taskName, required this.room,required this.cage,  this.isDone = false,required this.appointment});
}
