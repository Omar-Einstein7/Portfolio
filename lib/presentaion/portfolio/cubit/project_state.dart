



import 'package:portflio/domain/portfolio/entity/project_entity.dart';

abstract class ProjectsState {}

class ProjectsLoading extends ProjectsState {}

class ProjectsLoaded extends ProjectsState {
  final List<ProjectEntity> projects;
  ProjectsLoaded({required this.projects});
}

class FailureLoadProjects extends ProjectsState {
  final String errorMessage;
  FailureLoadProjects({required this.errorMessage});
}