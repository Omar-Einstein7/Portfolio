// import 'package:cloud_firestore/cloud_firestore.dart';

// class FetchProjects {
//   final FirebaseFirestore _firestore;
//   FetchProjects(this._firestore);

//   Future<List<Map<String, dynamic>>> fetchProjects() async {
//     try {
//       final response = await _firestore.collection("projects").get();
//       return response.docs.map((doc) => doc.data()).toList();
//     } on Exception catch (e) {
//       throw Exception('Failed to fetch projects: $e');
//     }
//   }
// }

import 'package:dartz/dartz.dart';

import 'package:portflio/service_locator.dart';

import '../../../core/network/FirestoreClient.dart';

abstract class PortfolioService {
  Future<Either> getProjects();
  Future<Either> setProject(String documentId, Map<String, dynamic> projectData);
}

class PortfolioServiceImpl extends PortfolioService{
  @override
  Future<Either> getProjects() async{
    try {
      var response = await sl<FirestoreClient>().getCollection("projects");
      return Right(response.docs.map((doc) => doc.data()).toList());
    } catch (e) {
      return Left(e);
    }
  }
  
  @override
 Future<Either<Exception, void>> setProject(String documentId, Map<String, dynamic> projectData) async {
    try {
      await sl<FirestoreClient>().setDocument("projects", documentId, projectData);
      return const Right(null);
    } catch (e) {
      print(e);
      return Left(Exception('Failed to set project: $e'));
    }
  }
}