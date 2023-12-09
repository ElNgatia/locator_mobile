import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {

  User({
    required this.name,
    required this.avatar,
    required this.currentLat,
    required this.currentLon,
    required this.previousLon,
    required this.previousLat,
    required this.time,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  String name;
  String avatar;
  String currentLat;
  String currentLon;
  String previousLon;
  String previousLat;
  int time;
  String id;
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
