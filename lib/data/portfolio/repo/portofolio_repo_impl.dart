// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:portflio/data/portfolio/model/project_model.dart';

// import '../../../domain/portfolio/repo/portfolio_repo.dart';
// import '../source/fetch_projects.dart';

// class PortofolioRepoImpl extends PortfolioRepo {
//   final FetchProjects _fetchProjects;

//   PortofolioRepoImpl()
//       : _fetchProjects = FetchProjects(FirebaseFirestore.instance);

//   @override
//   Future<List<ProjectModel>> fetchProjects() {
//     try {
//       return _fetchProjects.fetchProjects().then((snapshot) {
//         return snapshot.map((doc) => ProjectModel.fromJson(doc)).toList();
//       });
//     } on Exception catch (e) {
//       throw Exception('Failed to fetch projects: $e');
//     }
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:portflio/common/helper/mapper/projects_mapper.dart';
import 'package:portflio/data/portfolio/model/project_model.dart';
import 'package:portflio/data/portfolio/source/portfolio_service.dart';
import 'package:portflio/domain/portfolio/repo/portfolio_repo.dart';
import 'package:portflio/service_locator.dart';

class PortofolioRepoImpl extends PortfolioRepo{
  @override
  Future<Either> getProjects()async {
    var returnedData = await sl<PortfolioService>().getProjects();

    return returnedData.fold((error){
      return Left(error);
      }, (data){
        var projects = List.from(data).map((item) =>ProjectMapper.toEntity(ProjectModel.fromJson(item)) ).toList();
 return Right(projects); 
    });
  }
  
  @override
  Future<Either> setProject(String documentId, Map<String, dynamic> projectData) async {
    var returnedData = await sl<PortfolioService>().setProject(documentId, projectData);
    return returnedData.fold((error){
      return Left(error);
    }, (data){
      return const Right(null);
    });
  }

}