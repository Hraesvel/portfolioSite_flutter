import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'projectClass.g.dart';

@JsonSerializable()
class Project {
  Project(List<String>? tech, name, description, this.achievements, this.link,
      this.image, this.priority, this.bucket) {
    this._tech = tech;
    this._name = name;
    this._description = description;
  }

  int? priority = 0;

  List<String>? achievements;

  @JsonKey(name: 'name')
  String? _name;
  @JsonKey(name: 'description')
  String? _description;
  String? link;

  @JsonKey(name: 'tech')
  List<String>? _tech = [];
  @JsonKey()
  String? image;

  @JsonKey()
  String? thumb;
  String? bucket;

  String get name => utf8.decode(_name!.codeUnits);

  String get description => utf8.decode(_description!.codeUnits);

  List<String> get tech {
    return _tech!.map((e) => utf8.decode(e.codeUnits)).toList();
  }

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  @override
  String toString() {
    return '${this.name} : ${this.priority}';
  }
}
