
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Cast> fetchCast(String type) async{
  final url = "https://api.themoviedb.org/3/movie/$type/credits?api_key=62feaff3d2cf094a340f530fbf25bde9";

  final response = await http.get(url);
  print(url);
  if (response.statusCode == 200) {
    print(response.body);
    return Cast.fromJson(jsonDecode(response.body));
  }
  else
  {
    throw Exception(response.reasonPhrase);
  }
}

Cast castFromJson(String str) => Cast.fromJson(json.decode(str));

String castToJson(Cast data) => json.encode(data.toJson());

class Cast {
  Cast({
    this.id,
    this.cast,
    this.crew,
  });

  int id;
  List<CastElement> cast;
  List<Crew> crew;

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
    id: json["id"],
    cast: List<CastElement>.from(json["cast"].map((x) => CastElement.fromJson(x))),
    crew: List<Crew>.from(json["crew"].map((x) => Crew.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
    "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
  };
}

class CastElement {
  CastElement({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  factory CastElement.fromJson(Map<String, dynamic> json) => CastElement(
    castId: json["cast_id"],
    character: json["character"],
    creditId: json["credit_id"],
    gender: json["gender"],
    id: json["id"],
    name: json["name"],
    order: json["order"],
    profilePath: json["profile_path"],
  );

  Map<String, dynamic> toJson() => {
    "cast_id": castId,
    "character": character,
    "credit_id": creditId,
    "gender": gender,
    "id": id,
    "name": name,
    "order": order,
    "profile_path": profilePath,
  };
}

class Crew {
  Crew({
    this.creditId,
    this.department,
    this.gender,
    this.id,
    this.job,
    this.name,
    this.profilePath,
  });

  String creditId;
  String department;
  int gender;
  int id;
  String job;
  String name;
  String profilePath;

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
    creditId: json["credit_id"],
    department: json["department"],
    gender: json["gender"],
    id: json["id"],
    job: json["job"],
    name: json["name"],
    profilePath: json["profile_path"] == null ? null : json["profile_path"],
  );

  Map<String, dynamic> toJson() => {
    "credit_id": creditId,
    "department": department,
    "gender": gender,
    "id": id,
    "job": job,
    "name": name,
    "profile_path": profilePath == null ? null : profilePath,
  };
}