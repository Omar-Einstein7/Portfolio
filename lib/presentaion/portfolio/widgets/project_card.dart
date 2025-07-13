import 'package:flutter/material.dart';
import 'package:motion/motion.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String Url;
  final String description;
  final String imageUrl;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.onTap,
    required this.Url,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  bool _isHovering = false;
  bool isHover = false;
  bool isHover2 = false;
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 900;

    return Flex(
      direction: isSmallScreen ? Axis.vertical : Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: isSmallScreen ? screenWidth * 0.9 : screenWidth * 0.4,
          constraints: BoxConstraints(
            minHeight: isSmallScreen ? 200 : 300,
          ),
          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    fontSize: isSmallScreen ? 20 : 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                widget.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  MouseRegion(
                    onEnter: (_) => setState(() => isHover = true),
                    onExit: (_) => setState(() => isHover = false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: isSmallScreen ? 110 : 120,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        gradient: LinearGradient(
                          colors: isHover
                              ? [Colors.blue.shade400, Colors.blue.shade600]
                              : [Colors.transparent, Colors.transparent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: isHover ? Colors.blue.shade400 : Colors.white,
                          width: 2,
                        ),
                        boxShadow: isHover
                            ? [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                )
                              ]
                            : [],
                      ),
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: TextStyle(
                            color: isHover ? Colors.white : Colors.blue,
                            fontSize: isSmallScreen ? 12 : 14,
                            fontWeight: FontWeight.bold,
                          ),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("See Live"),
                                  AnimatedPadding(
                                    duration: const Duration(milliseconds: 300),
                                    padding: EdgeInsets.only(
                                        left: isHover ? 8.0 : 4.0),
                                    child: AnimatedRotation(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      turns: isHover ? 0.125 : 0,
                                      child: Icon(
                                        Icons.arrow_forward,
                                        size: isSmallScreen ? 14 : 16,
                                        color: isHover
                                            ? Colors.white
                                            : Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  MouseRegion(
                    onEnter: (_) => setState(() => isHover2 = true),
                    onExit: (_) => setState(() => isHover2 = false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: isSmallScreen ? 110 : 120,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        gradient: LinearGradient(
                          colors: isHover2
                              ? [Colors.purple.shade400, Colors.purple.shade600]
                              : [Colors.transparent, Colors.transparent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color:
                              isHover2 ? Colors.purple.shade400 : Colors.white,
                          width: 2,
                        ),
                        boxShadow: isHover2
                            ? [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                )
                              ]
                            : [],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            final url = Uri.parse(widget.Url);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url,
                                  mode: LaunchMode.externalApplication);
                            }
                          },
                          borderRadius: BorderRadius.circular(30.0),
                          child: Center(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              style: TextStyle(
                                color: isHover2 ? Colors.white : Colors.purple,
                                fontSize: isSmallScreen ? 12 : 14,
                                fontWeight: FontWeight.bold,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.code,
                                    size: isSmallScreen ? 14 : 16,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text("Source Code"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        if (!isSmallScreen) const SizedBox(width: 20),
        MouseRegion(
          onEnter: (_) {
            setState(() => _isHovering = true);
            _controller.forward();
          },
          onExit: (_) {
            setState(() => _isHovering = false);
            _controller.reverse();
          },
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -10 * _animation.value),
                child: Material(
                  elevation: 12 + (4 * _animation.value),
                  shadowColor: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.imageUrl,
                      width:
                          isSmallScreen ? screenWidth * 0.9 : screenWidth * 0.5,
                      height: isSmallScreen ? 250 : 400,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(20)),
                            width: isSmallScreen
                                ? screenWidth * 0.9
                                : screenWidth * 0.5,
                            height: isSmallScreen ? 250 : 400,
                            child: const Icon(Icons.broken_image,
                                size: 64, color: Colors.grey));
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
