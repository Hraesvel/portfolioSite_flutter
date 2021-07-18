import 'package:json_annotation/json_annotation.dart';
import 'projectClass.dart';

part 'projectDataClass.g.dart';

@JsonSerializable()
class ProjectData {
  ProjectData(this.frontend, this.backend);

  List<Project>? frontend = [];
  List<Project>? backend = [];

  factory ProjectData.fromJson(Map<String, dynamic> json) =>
      _$ProjectDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectDataToJson(this);

  void sortProjects({reverseFrontend: false, reverseBackend: false}) {
    if (!reverseFrontend)
      frontend!.sort((a, b) => a.priority!.compareTo(b.priority!));
    else
      frontend!.sort((a, b) => b.priority!.compareTo(a.priority!));

    if (!reverseBackend)
      backend!.sort((a, b) => a.priority!.compareTo(b.priority!));
    else
      backend!.sort((a, b) => b.priority!.compareTo(a.priority!));
  }
}
