import 'package:dartz/dartz.dart';
import 'package:portflio/core/usecase/usecase.dart';
import 'package:portflio/domain/portfolio/repo/portfolio_repo.dart';
import 'package:portflio/service_locator.dart';

class SetProjectUseCase extends Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    // Assuming params is a Map with 'documentId' and 'data'
    final String documentId = params!['documentId'];
    final Map<String, dynamic> data = params['data'];
    return await sl<PortfolioRepo>().setProject(documentId, data);
  }
}