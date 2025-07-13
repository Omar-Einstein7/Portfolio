import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class AboutSection extends StatefulWidget {
    
  
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DiagonalPathClipperTwo(),
      child: Container(
        constraints: const BoxConstraints(minHeight: 50),
        padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 64.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2C3E50), Color(0xFF3498DB)],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'About Me',
              style: TextStyle(
                fontSize: 42.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40.0),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 1000) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildAnimatedAvatar(),
                      const SizedBox(width: 48),
                      SizedBox(
                        width: constraints.maxWidth * 0.5, // Set fixed width
                        child: _buildAboutContent(),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      _buildAnimatedAvatar(),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: constraints.maxWidth, // Set fixed width
                        child: _buildAboutContent(),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedAvatar() {
    return AnimatedBuilder(
      animation: CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
      ),
      builder: (context, child) {
        return TweenAnimationBuilder(
          duration: const Duration(seconds: 2),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, double value, child) {
            return Transform.translate(
              offset: Offset(0, 10 * sin(value * pi * 2)),
              child: Transform.scale(
                scale: 0.9 + (value * 0.1),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2 + (0.1 * value)),
                        spreadRadius: 5 * value,
                        blurRadius: 15 * value,
                        offset: Offset(0, 5 * value),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 150.0,
                    backgroundImage: AssetImage('assets/ME2.jpg'),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAboutContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '''Hello! I'm a passionate developer with a keen interest in creating beautiful and functional applications. With expertise in multiple programming languages and frameworks, I strive to deliver high-quality solutions that make a difference.

I believe in continuous learning and staying up-to-date with the latest technologies. When I'm not coding, you can find me exploring new tech trends, contributing to open-source projects, or sharing knowledge with the developer community.''',
          style: TextStyle(
            fontSize: 18.0,
            height: 1.6,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 32.0),
        MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: Container(
            width: 200, // Fixed width for button container
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.transparent,
              border: Border.all(color: Colors.white),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: isHovered ? 220 : 0, // Match container width
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white.withOpacity(0.7),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: isHovered ? 1.05 : 1.0,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor:
                            isHovered ? Colors.blueAccent : Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 45.0,
                          vertical: 16.0,
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        "View My Github",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
