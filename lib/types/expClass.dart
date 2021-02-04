import 'package:json_annotation/json_annotation.dart';

part 'expClass.g.dart';

@JsonSerializable()
class Experience {
  Experience(this.name, this.start, this.end, this.isCurrent, this.isUTC,
      this.headline, this.description);

  String name;
  bool isCurrent;
  int start;
  int end;
  bool isUTC = true;
  String headline;
  String description;
  List<String> achievements;

  factory Experience.fromJson(Map<String, dynamic> json) => _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}
