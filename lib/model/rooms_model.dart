class Rooms_Model {
  int id;
  final String roomName;
  int cagesCount ;

  Rooms_Model({ this.id=0,required this.roomName, this.cagesCount=0});



  Map<String,dynamic> room_to_map(){
    var mapping = Map<String,dynamic>();

    mapping['roomName']=roomName;
    mapping['cagesCount']=cagesCount;

    return mapping;
  }



}