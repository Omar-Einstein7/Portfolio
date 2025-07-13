import '../../../domain/portfolio/entity/project_entity.dart';

class ProjectModel extends ProjectEntity {
  ProjectModel({
    required super.title,
    required super.description,
    required super.link,
    required super.imageurl,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      title: json['title'] as String,
      description: json['description'] as String,
      link: json['link'] as String,
      imageurl: json['imageUrl'] as String,
    );
  }
}
