
import 'package:get_it/get_it.dart';
import 'package:portflio/core/network/FirestoreClient.dart';
import 'package:portflio/data/portfolio/repo/portofolio_repo_impl.dart';
import 'package:portflio/data/portfolio/source/portfolio_service.dart';
import 'package:portflio/domain/portfolio/repo/portfolio_repo.dart';

import 'domain/portfolio/usecase/fetch_project_usecase.dart';
import 'domain/portfolio/usecase/set_project_usecase.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<FirestoreClient>(FirestoreClient());

  //Services
  sl.registerSingleton<PortfolioService>(PortfolioServiceImpl());

  //Repo
    sl.registerSingleton<PortfolioRepo>(PortofolioRepoImpl());

  //UseCase
   sl.registerSingleton<GetProjectsUseCase>(GetProjectsUseCase());
     sl.registerSingleton<SetProjectUseCase>(SetProjectUseCase()); // New registration

}