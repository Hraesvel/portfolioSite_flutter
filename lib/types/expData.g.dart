// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpData _$ExpDataFromJson(Map<String, dynamic> json) {
  return ExpData(
    json['count'] as int?,
    (json['data'] as List<dynamic>?)
        ?.map((e) => Experience.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ExpDataToJson(ExpData instance) => <String, dynamic>{
      'count': instance.count,
      'data': instance.data,
    };
