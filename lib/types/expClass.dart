import 'package:json_annotation/json_annotation.dart';

part 'expClass.g.dart';

@JsonSerializable()
class Exp {
  Exp(this.name, this.start, this.end, this.isCurrent, this.isUTC,
      this.headline, this.description);

  String name;
  bool isCurrent;
  int start;
  int end;
  bool isUTC = true;
  String headline;
  String description;
  List<String> achievements;

  factory Exp.fromJson(Map<String, dynamic> json) => _$ExpFromJson(json);

  Map<String, dynamic> toJson() => _$ExpToJson(this);
}
