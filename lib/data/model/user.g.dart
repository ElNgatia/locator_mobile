// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      currentLat: json['currentLat'] as String,
      currentLon: json['currentLon'] as String,
      previousLon: json['previousLon'] as String,
      previousLat: json['previousLat'] as String,
      time: json['time'] as int,
      id: json['id'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'avatar': instance.avatar,
      'currentLat': instance.currentLat,
      'currentLon': instance.currentLon,
      'previousLon': instance.previousLon,
      'previousLat': instance.previousLat,
      'time': instance.time,
      'id': instance.id,
    };
