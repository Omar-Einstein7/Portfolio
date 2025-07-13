// import '../../../data/portfolio/model/project_model.dart';

// abstract class PortfolioRepo {
//   Future<List<ProjectModel>> fetchProjects();
// }

import 'package:dartz/dartz.dart';

abstract class PortfolioRepo {
  Future<Either> getProjects();
    Future<Either> setProject(String documentId, Map<String, dynamic> projectData);
}
