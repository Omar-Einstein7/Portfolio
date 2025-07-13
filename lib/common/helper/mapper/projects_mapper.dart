
import 'package:portflio/domain/portfolio/entity/project_entity.dart';

import '../../../data/portfolio/model/project_model.dart';

class ProjectMapper {
  static ProjectEntity toEntity(ProjectModel project) {
    return ProjectEntity(
      title: project.title,
      description: project.description, 
      link: project.link,
      imageurl: project.imageurl,
    );
  }
}
