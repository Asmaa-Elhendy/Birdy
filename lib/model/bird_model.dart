final String tableBirds = 'birds';


class BirdsFields{
  static final List<String> values = [
    /// Add all fields
    id, name, type, color, ringNum, ringType, age, gender, breed, image, cageId, roomId, cageName, roomName
  ];

  static final String id = "_id";
  static final String name = "name";
  static final String type = "type";
  static final String color = "color";
  static final String ringNum = "ringNum";
  static final String ringType = "ringType";
  static final String age = "age";
  static final String gender = "gender";
  static final String breed = "breed";
  static final String image = "image";
  static final String cageId = "cageId";
  static final String roomId = "roomId";
  static final String cageName = "cageName";
  static final String roomName = "roomName";

}


class Bird {
   int? id;
   String type;
   String name;
   String color;
   int? ringNum;
   String? ringType;
   int age;
   String gender;
   String breed;
   String? image;
   int cageId;
   int roomId;
   String cageName;
   String roomName;

  Bird(
      {this.id,
      required this.name,
      this.image,
      this.ringType,
      required this.color,
      required this.type,
      required this.age,
      required this.breed,
      required this.gender,
      this.ringNum,
        required this.cageId,
        required this.cageName,
        required this.roomId,
        required this.roomName

      });

  Bird copy({
    int? id,
  String? type,
     String? name,
     String? color,
     int? ringNum,
     String? ringType,
     int? age,
     String? gender,
     String? breed,
     String? image,
     int? cageId,
     int? roomId,
     String? cageName,
     String? roomName,

  }) =>
      Bird(
        id: id ?? this.id,
        color:  color ?? this.color,
        image: image ?? this.image,
        name: name??this.name,
        age: age??this.age,
        breed: breed??this.breed,
        gender: gender??this.gender,
        type: type??this.type,
        ringNum: ringNum?? this.ringNum,
        ringType: ringType??this.ringType,
        cageId: cageId??this.cageId,
        cageName: cageName??this.cageName,
        roomId: roomId??this.roomId,
        roomName: roomName??this.roomName
      );

  Map<String, dynamic> toJson() => {

    //**************
    BirdsFields.id: id,
    BirdsFields.name: name,
    BirdsFields.image: image,
    BirdsFields.type: type,
    BirdsFields.gender: gender,
    BirdsFields.color: color,
    BirdsFields.ringType: ringType,
    BirdsFields.age: age,
    BirdsFields.ringNum: ringNum,
    BirdsFields.breed: breed,
    BirdsFields.cageId:cageId,
    BirdsFields.cageName:cageName,
    BirdsFields.roomId:roomId,
    BirdsFields.roomName:roomName
  };

  static Bird fromJson(Map<String, Object?> json) {

    return Bird(

        id: json[BirdsFields.id] as int?,
        image: json[BirdsFields.image] as String?,
        color: json[BirdsFields.color] as String,
        name: json[BirdsFields.name] as String,
      ringNum: json[BirdsFields.ringNum] as int?,
      ringType: json[BirdsFields.ringType] as String?,
      type: json[BirdsFields.type] as String,
      gender: json[BirdsFields.gender] as String,
      breed: json[BirdsFields.breed] as String,
      age: json[BirdsFields.age] as int,
      roomName: json[BirdsFields.roomName] as String,
      roomId: json[BirdsFields.roomId] as int,
      cageId: json[BirdsFields.cageId] as int,
      cageName: json[BirdsFields.cageName] as String,
    );
  }
}
