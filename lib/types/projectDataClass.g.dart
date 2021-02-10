// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projectDataClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectData _$ProjectDataFromJson(Map<String, dynamic> json) {
  return ProjectData(
    (json['frontend'] as List)
        ?.map((e) =>
            e == null ? null : Project.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['backend'] as List)
        ?.map((e) =>
            e == null ? null : Project.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProjectDataToJson(ProjectData instance) =>
    <String, dynamic>{
      'frontend': instance.frontend,
      'backend': instance.backend,
    };
