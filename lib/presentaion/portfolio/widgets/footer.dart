import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  final void Function()? goHero;
  const Footer({super.key, this.goHero});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;
      double verticalPadding = maxWidth > 600 ? 60.0 : 40.0;
      double iconSize = maxWidth > 600 ? 20.0 : 20.0;
      double dividerWidth = maxWidth > 600 ? 600.0 : 300.0;
      return Container(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        color: const Color(0xFF333333),
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.keyboard_arrow_up,
                  color: Colors.white, size: iconSize),
              onPressed: goHero,
            ),
            SizedBox(height: verticalPadding / 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                HoverIcon(
                    icon: FaIcon(FontAwesomeIcons.github, size: iconSize),
                    color2: Colors.black,
                    color: Colors.white,
                    url: "https://github.com/Omar-Einstein7"),
                HoverIcon(
                    icon: FaIcon(FontAwesomeIcons.instagram, size: iconSize),
                    color2: Colors.pinkAccent,
                    color: Colors.white,
                    url: "https://www.instagram.com/omarmendes_12/"),
                HoverIcon(
                    icon: FaIcon(FontAwesomeIcons.linkedinIn, size: iconSize),
                    color2: Colors.blueAccent,
                    color: Colors.white,
                    url: "https://www.linkedin.com/in/omar-ahmed-b13440218/"),
                HoverIcon(
                    icon: FaIcon(FontAwesomeIcons.facebookF, size: iconSize),
                    color2: Colors.blue,
                    color: Colors.white,
                    url: "https://www.facebook.com/omar.ahmed.460201"),
              ],
            ),
            SizedBox(height: verticalPadding / 3),
            Container(height: 1.0, width: dividerWidth, color: Colors.white54),
            SizedBox(height: verticalPadding / 3),
            const Text(
              '© 2025 - Template by Omar Ahmed.',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
            const SizedBox(height: 5.0),
            const Text(
              'Made with ♥',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ],
        ),
      );
    });
  }
}

class HoverIcon extends StatefulWidget {
  final Widget icon;
  final Color color;
  final Color color2;
  final String url;
  const HoverIcon(
      {super.key,
      required this.icon,
      required this.color,
      required this.color2,
      required this.url});

  @override
  State<HoverIcon> createState() => _HoverIconState();
}

class _HoverIconState extends State<HoverIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.7 : 1.2,
        duration: const Duration(milliseconds: 200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: IconButton(
            padding: EdgeInsets.symmetric(horizontal: 10),
            icon: widget.icon,
            color: _isHovered ? widget.color2 : widget.color,
            onPressed: () async {
              final url = Uri.parse(widget.url);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
          ),
        ),
      ),
    );
  }
}
