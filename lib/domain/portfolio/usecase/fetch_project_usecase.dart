// import '../../../data/portfolio/model/project_model.dart';
// import '../repo/portfolio_repo.dart';

// class FetchProjectUsecase {
//   final PortfolioRepo _portfolioRepo;

//   FetchProjectUsecase(this._portfolioRepo);

//   Future<List<ProjectModel>> call() async {
//     return await _portfolioRepo.fetchProjects();
//   }
// }
import 'package:dartz/dartz.dart';
import 'package:portflio/core/usecase/usecase.dart';
import 'package:portflio/domain/portfolio/repo/portfolio_repo.dart';
import 'package:portflio/service_locator.dart';

class GetProjectsUseCase extends Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<PortfolioRepo>().getProjects();
  }
}
