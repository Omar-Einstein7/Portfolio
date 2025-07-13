import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion/motion.dart';
import 'package:portflio/presentaion/portfolio/widgets/project_card.dart';

import '../../cubit/project_cubit.dart';
import '../../cubit/project_state.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {

  


  @override
  void initState() {
    super.initState();
 
  }

  @override
  Widget build(BuildContext context) {
   
    
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            'My Projects',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          BlocBuilder<ProjectCubit, ProjectsState>(
            builder: (context, state) {
              if (state is ProjectsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProjectsLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.projects.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ProjectCard(
                          title: state.projects[index].title,
                          description: state.projects[index].description,
                          imageUrl: state.projects[index].imageurl,
                          Url: state.projects[index].link,
                        ),
                      );
                    },
                  );
                
              }
              if (state is FailureLoadProjects) {
                return Center(child: Text(state.errorMessage));
              }
              return const Center(child: Text('Unknown state'));
            },
          ),
        ],
      ),
    );
  }
}
