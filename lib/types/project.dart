import 'package:json_annotation/json_annotation.dart';
part 'project.g.dart';

@JsonSerializable()
class Project {
  Project(this.name,
      this.description,
      this.link,
      this.image,
      this.tech,
      this.priority,
      this.bucket);

  int priority = 0;
  String name;
  String description;
  String link;
  List<String> tech = [];
  String image;
  String thumb;
  String bucket;


  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}