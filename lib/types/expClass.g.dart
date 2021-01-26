// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exp _$ExpFromJson(Map<String, dynamic> json) {
  return Exp(
    json['name'] as String,
    json['start'] as int,
    json['end'] as int,
    json['isCurrent'] as bool,
    json['isUTC'] as bool,
    json['headline'] as String,
    json['description'] as String,
  )..achievements =
      (json['achievements'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$ExpToJson(Exp instance) => <String, dynamic>{
      'name': instance.name,
      'isCurrent': instance.isCurrent,
      'start': instance.start,
      'end': instance.end,
      'isUTC': instance.isUTC,
      'headline': instance.headline,
      'description': instance.description,
      'achievements': instance.achievements,
    };
