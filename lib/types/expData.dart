import 'package:json_annotation/json_annotation.dart';

import '../types/expClass.dart';

part 'expData.g.dart';

@JsonSerializable()
class ExpData {
  ExpData(this.count, this.data);

  int? count = 0;
  List<Experience>? data = [];

  factory ExpData.fromJson(Map<String, dynamic> json) => _$ExpDataFromJson(json);

  Map<String, dynamic> toJson() => _$ExpDataToJson(this);
}
