import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TwitterIntroPage extends StatefulWidget {
  const TwitterIntroPage({Key? key}) : super(key: key);

  @override
  State<TwitterIntroPage> createState() => _TwitterIntroPageState();
}

class _TwitterIntroPageState extends State<TwitterIntroPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500)
    );

    final curvedAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _fadeAnimation = Tween(begin:  1.0, end: 0.0).animate(curvedAnimation);
    _scaleAnimation = Tween(begin:  1.0, end: 20.0).animate(curvedAnimation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1DA1F2),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: const FaIcon(FontAwesomeIcons.twitter, color: Colors.white, size: 40)
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _controller.forward(from: 0.0).then((_) => _controller.reset()),
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}