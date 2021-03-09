// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projectClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return Project(
    (json['tech'] as List)?.map((e) => e as String)?.toList(),
    json['name'],
    json['description'],
    (json['achievements'] as List)?.map((e) => e as String)?.toList(),
    json['link'] as String,
    json['image'] as String,
    json['priority'] as int,
    json['bucket'] as String,
  )..thumb = json['thumb'] as String;
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'priority': instance.priority,
      'achievements': instance.achievements,
      'link': instance.link,
      'image': instance.image,
      'thumb': instance.thumb,
      'bucket': instance.bucket,
      'name': instance.name,
      'description': instance.description,
      'tech': instance.tech,
    };
