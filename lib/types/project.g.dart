// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return Project(
    json['name'] as String,
    json['description'] as String,
    json['link'] as String,
    json['image'] as String,
    (json['tech'] as List)?.map((e) => e as String)?.toList(),
    json['priority'] as int,
    json['bucket'] as String,
  )..thumb = json['thumb'] as String;
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'priority': instance.priority,
      'name': instance.name,
      'description': instance.description,
      'link': instance.link,
      'tech': instance.tech,
      'image': instance.image,
      'thumb': instance.thumb,
      'bucket': instance.bucket,
    };
