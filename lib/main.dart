import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion/motion.dart';
import 'package:portflio/firebase_options.dart';
import 'package:portflio/presentaion/portfolio/cubit/project_cubit.dart';
import 'package:portflio/presentaion/portfolio/screens/protfolio_screen.dart';
import 'package:portflio/presentaion/portfolio/screens/sections/hero_section.dart';
import 'package:portflio/service_locator.dart';

import 'presentaion/portfolio/screens/sections/about_section.dart';
import 'presentaion/portfolio/screens/sections/contact_section.dart';
import 'presentaion/portfolio/screens/sections/projects_section.dart';
import 'presentaion/portfolio/widgets/footer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupServiceLocator();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProjectCubit()..GetProjects(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DevFolio Flutter',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    final GlobalKey _aboutSectionKey = GlobalKey();
    final GlobalKey _projectsSectionKey = GlobalKey();
    final GlobalKey _heroSectionKey = GlobalKey();

    void _scrollToTarget(BuildContext context) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('DevFolio'),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: LayoutBuilder(builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          double verticalSpacing = maxWidth > 600 ? 30.0 : 15.0;
          return Column(
            children: <Widget>[
              HeroSection(
                key: _heroSectionKey,
                goAbout: () =>
                    _scrollToTarget(_aboutSectionKey.currentContext!),
                goProjects: () =>
                    _scrollToTarget(_projectsSectionKey.currentContext!),
              ),
              AboutSection(key: _aboutSectionKey),
              SizedBox(
                height: verticalSpacing,
              ),
              ProjectsSection(
                key: _projectsSectionKey,
              ),
              ContactSection(),
              Footer(
                goHero: () => _scrollToTarget(_heroSectionKey.currentContext!),
              ),
            ],
          );
        }),
      ),
    );
  }
}
