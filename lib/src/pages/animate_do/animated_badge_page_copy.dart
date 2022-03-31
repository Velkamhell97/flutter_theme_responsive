import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimatedBadgePage extends StatefulWidget {
  const AnimatedBadgePage({Key? key}) : super(key: key);

  @override
  State<AnimatedBadgePage> createState() => _AnimatedBadgePageState();
}

class _AnimatedBadgePageState extends State<AnimatedBadgePage> {
  final ValueNotifier<int> _counterNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Animated Badge'),
      ),
      bottomNavigationBar: _BottomNavigation(
        onTap: (index) => print(index),
        counterNotifier: _counterNotifier,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>  _counterNotifier.value = _counterNotifier.value + 1,
        backgroundColor: Colors.pink,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

class _BottomNavigation extends StatefulWidget {
  final ValueChanged<int>? onTap;
  final ValueNotifier<int> counterNotifier;

  const _BottomNavigation({Key? key, this.onTap, required this.counterNotifier}) : super(key: key);

  @override
  State<_BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<_BottomNavigation> {

  int _activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _activeTab,
      selectedItemColor: Colors.pink,
      onTap: (value) {
        if(value == _activeTab) return;

        if(widget.onTap != null){
          widget.onTap!(value);
        }
        
        setState(() => _activeTab = value);
      },
      items: [
        const BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.bone),
          label: 'Bones'
        ),
        BottomNavigationBarItem(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const FaIcon(FontAwesomeIcons.bell),
              Positioned(
                top: -10,
                right: -5,
                child: ValueListenableBuilder<int>(
                  valueListenable: widget.counterNotifier,
                  builder: (_, counter, __) {
                    

                    return Align(child: _AnimatedBadge(counter: counter));
                  },
                ),
              )
            ],
          ),
          label: 'Bones'
        ),
        const BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.dog),
          label: 'Bones'
        ),
      ],
    );
  }
}

class _AnimatedBadge extends StatefulWidget {
  final int counter;

  const _AnimatedBadge({Key? key, this.counter = 0}) : super(key: key);

  @override
  __AnimatedBadgeState createState() => __AnimatedBadgeState();
}

class __AnimatedBadgeState extends State<_AnimatedBadge> with TickerProviderStateMixin {
  late final AnimationController _firstAnimationController;
  late final AnimationController _animationController;

  late final Animation<double> _firstDownAnimation;
  late final Animation<double> _firstOpacityAnimation;

  late final Animation<double> _upAnimation;
  late final Animation<double> _downAnimation;

  @override
  void initState() {
    super.initState();

    //*-----First Animation
    _firstAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
    );

    _firstOpacityAnimation = CurvedAnimation(
      parent: _firstAnimationController, 
      curve: Curves.ease
    );

     _firstDownAnimation = CurvedAnimation(
      parent: _firstAnimationController, 
      curve: Curves.bounceOut
    );

    //*-----Nexts Animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
    );

    _upAnimation = CurvedAnimation(
      parent: _animationController, 
      curve: const Interval(0.00, 0.50)
    );

    _downAnimation = CurvedAnimation(
      parent: _animationController, 
      curve: const Interval(0.50, 1.00, curve: Curves.bounceOut)
    );
  }

  @override
  void dispose() {
    _firstAnimationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.counter > 1){
      _animationController.forward(from: 0.0);
    } else if(widget.counter == 1){
      _firstAnimationController.forward();
    }

    //-La ventaja de esta forma esque no tenemos que hacer condicionales solo escuchamos diferentes
    //-listeners
    return AnimatedBuilder(
      animation: Listenable.merge([_firstAnimationController, _animationController]),
      builder: (context, child) {
        final up = -10 * _upAnimation.value;
        final down = 10 * _downAnimation.value;

        return Opacity(
          opacity: _firstOpacityAnimation.value,
          child: Transform.translate(
            offset: Offset(0.0, -10 * (1 - _firstDownAnimation.value)),
            child: Transform.translate(
              offset: Offset(0.0, up + down),
              child: child,
            ),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
        padding: const EdgeInsets.all(4.0),
        child: Text(
          '${widget.counter}', 
          style: const TextStyle(color: Colors.white, fontSize: 10)
        ),
      ) ,
    );
  }
}