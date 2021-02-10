import 'package:json_annotation/json_annotation.dart';
import 'projectClass.dart';

part 'projectDataClass.g.dart';

@JsonSerializable()
class ProjectData {
  ProjectData(this.frontend, this.backend);

  List<Project> frontend = [];
  List<Project> backend = [];


  factory ProjectData.fromJson(Map<String, dynamic> json) => _$ProjectDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectDataToJson(this);
}
