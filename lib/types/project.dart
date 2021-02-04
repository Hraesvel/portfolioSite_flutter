import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'project.g.dart';

@JsonSerializable()
class Project {
  Project(
      List<String> tech,
      this.name,
      this.description,
      this.link,
      this.image,
      this.priority,
      this.bucket)
  {
    this._tech = tech;
  }

  int priority = 0;
  String name;
  String description;
  String link;
  @JsonKey(name: 'tech')
  List<String> _tech = [];
  String image;
  String thumb;
  String bucket;

  List<String> get tech {
    return _tech.map((e) => utf8.decode(e.codeUnits)).toList();
  }


  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}