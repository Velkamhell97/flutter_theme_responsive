import 'package:flutter/material.dart';

class MultiAnimationPage extends StatefulWidget {
  const MultiAnimationPage({Key? key}) : super(key: key);

  @override
  State<MultiAnimationPage> createState() => _MultiAnimationPageState();
}

class _MultiAnimationPageState extends State<MultiAnimationPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _fadeInDownTitle;
  late final Animation<double> _fadeInDownSubtitle;
  late final Animation<double> _fadeInRight;
  late final Animation<double> _fadeInScaleInLogo;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2)
    );

    _fadeInDownTitle = CurvedAnimation(
      parent: _controller, 
      curve: const Interval(0.00, 0.25, curve: Curves.easeOut)
    );

    _fadeInDownSubtitle = CurvedAnimation(
      parent: _controller, 
      curve: const Interval(0.2, 0.45, curve: Curves.easeOut)
    );

    _fadeInRight = CurvedAnimation(
      parent: _controller, 
      curve: const Interval(0.40, 0.65, curve: Curves.easeIn)
    );

    _fadeInScaleInLogo = CurvedAnimation(
      parent: _controller, 
      curve: const Interval(0.6, 0.85, curve: Curves.elasticOut)
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Animation Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _fadeInScaleInLogo,
              child: ScaleTransition(
                scale: _fadeInScaleInLogo,
                child: const Icon(Icons.new_releases, color: Colors.blue, size: 40)
              )
            ),
            FadeTransition(
              opacity: _fadeInDownTitle,
              child: SlideTransition(
                position: Tween(
                  begin: const Offset(0.0, -1.0), 
                  end: Offset.zero
                ).animate(_fadeInDownTitle),
                child: const Text(
                  'Titulo',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200),
                ),
              ),
            ),
            FadeTransition(
              opacity: _fadeInDownSubtitle,
              child: SlideTransition(
                position: Tween(
                  begin: const Offset(0.0, -3.5), 
                  end: Offset.zero
                ).animate(_fadeInDownSubtitle),
                child: const Text(
                  'Soy un pequeño texto',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            FadeTransition(
              opacity: _fadeInRight,
              child: SlideTransition(
                position: Tween(
                  begin: const Offset(-1.0, 0.0), 
                  end: Offset.zero
                ).animate(_fadeInRight),
                child: Container(
                  height: 2,
                  width: 220,
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 1000),
        /// Por alguna razon el elastic afecta la direccion
        curve: const ElasticOutCurve(0.6),
        tween: Tween(begin: 1, end: 0),
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(-200 * value, 0.0),
            child: child,
          );
        },
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
}