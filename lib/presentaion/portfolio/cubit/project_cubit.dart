import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portflio/domain/portfolio/usecase/fetch_project_usecase.dart';
import 'package:portflio/presentaion/portfolio/cubit/project_state.dart';
import 'package:portflio/service_locator.dart';

import '../../../domain/portfolio/usecase/set_project_usecase.dart';

class ProjectCubit extends Cubit<ProjectsState> {
  ProjectCubit() : super(ProjectsLoading());


  void GetProjects() async {
    var returnedData = await sl<GetProjectsUseCase>().call();
    returnedData.fold(
      (error){
        emit(
          FailureLoadProjects(errorMessage: error.toString())
        );
      },
      (data){
        emit(
          ProjectsLoaded(projects: data)
        );
      }
    );
  }
    Future<void> setProject(String documentId, Map<String, dynamic> projectData) async {
    emit(ProjectsLoading());
    final result = await sl<SetProjectUseCase>().call(params: {'documentId': documentId, 'data': projectData});
    result.fold(
      (error) => emit(FailureLoadProjects(errorMessage: error.toString())),
      (_) => GetProjects(), // Refresh projects after setting
    );
  }
}