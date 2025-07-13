import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portflio/presentaion/portfolio/cubit/project_cubit.dart';
import 'package:portflio/presentaion/portfolio/cubit/project_state.dart';

class ProtfolioScreen extends StatelessWidget {
  const ProtfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProjectCubit, ProjectsState>(
          builder: (context, state) {
            if (state is ProjectsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProjectsLoaded) {
              // return Container(
              //   width: 500,
              //   height: 500,
              //   child: ListView.builder(
              //     itemCount: 1,
              //     itemBuilder: (context, index) {
              //       return ListTile(
              //         title: Text(state.projects[index].title),
              //         subtitle: Text(state.projects[index].description),
              //       );
              //     },
              //   ),
              // );
              return ListView.builder(
                itemCount: state.projects.length,
                itemBuilder: (context, index) {
                  final project = state.projects[index];
                  return ListTile(
                    title: Text(project.title),
                    subtitle: Text(project.description),
                  );
                },
              );
            }
            if (state is FailureLoadProjects) {
              return Center(child: Text(state.errorMessage));
            }
            return Center(child: Text('Unknown state'));
          },
        ),
      ),
    );
  }
}