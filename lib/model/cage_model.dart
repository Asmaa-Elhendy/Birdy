final String tableCages = 'cages';

class CagesFields{
  static final List<String> values = [
    /// Add all fields
    id, room_id, cageName, birdNumbers, cleaningDays, feedingDays,wateringDays,roomName
  ];

  static final String id = "_id";
  static final String room_id = "roomId";
  static final String cageName = "cageName";
  static final String birdNumbers = "birdNumbers";
  static final String cleaningDays = "cleaningDays";
  static final String feedingDays = "feedingDays";
  static final String wateringDays = "wateringDays";
  static final String roomName = "roomName";
}


class Cage{
   int? id;
   int room_id;
   String cageName;
   int birdNumbers;
   String cleaningDays;
   String feedingDays;
   String wateringDays;
   String roomName;

 Cage({ this.id,required this.cageName,  this.birdNumbers=0,required this.cleaningDays,required this.feedingDays,required this.wateringDays,required this.room_id,required this.roomName});

   Cage copy({
     int? id,
     int? room_id,
     String? cageName,
     int? birdNumbers,
     String? cleaningDays,
     String? feedingDays,
     String? wateringDays,
     String?roomName
   }) {
     print("id creet${id}");

     return Cage(
         id: id ?? this.id,
         room_id: room_id ?? this.room_id,
         cageName: cageName ?? this.cageName,
         birdNumbers: birdNumbers ?? this.birdNumbers,
         cleaningDays: cleaningDays ?? this.cleaningDays,
         feedingDays: feedingDays ?? this.feedingDays,
         wateringDays: wateringDays ?? this.wateringDays,
         roomName: roomName??this.roomName

     );
   }

   Map<String, Object?> toJson() => {
     CagesFields.id: id,
     CagesFields.cageName: cageName,
     CagesFields.birdNumbers: birdNumbers,
     CagesFields.room_id: room_id,
     CagesFields.cleaningDays: cleaningDays,
     CagesFields.feedingDays: feedingDays,
     CagesFields.wateringDays: wateringDays,
     CagesFields.roomName:roomName
   };

   static Cage fromJson(Map<String, Object?> json) => Cage(
     id: json[CagesFields.id] as int?,
     cageName: json[CagesFields.cageName]  as String,
     room_id: json[CagesFields.room_id] as int,
     birdNumbers: json[CagesFields.birdNumbers] as int,
     cleaningDays:  json[CagesFields.cleaningDays] as String,
     feedingDays:  json[CagesFields.feedingDays] as String,
     wateringDays:  json[CagesFields.wateringDays] as String,
     roomName: json[CagesFields.roomName] as String,

   );


}
