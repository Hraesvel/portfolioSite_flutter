import 'package:json_annotation/json_annotation.dart';
part 'project.g.dart';

@JsonSerializable()
class Project {
  Project(this.name,
      this.description,
      this.link,
      this.image,
      this.tech);

  String name;
  String description;
  String link;
  List<String> tech = [];
  String image;


  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}