// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return Project(
    (json['tech'] as List)?.map((e) => e as String)?.toList(),
    json['name'] as String,
    json['description'] as String,
    json['link'] as String,
    json['image'] as String,
    json['priority'] as int,
    json['bucket'] as String,
  )..thumb = json['thumb'] as String;
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'priority': instance.priority,
      'name': instance.name,
      'description': instance.description,
      'link': instance.link,
      'image': instance.image,
      'thumb': instance.thumb,
      'bucket': instance.bucket,
      'tech': instance.tech,
    };
