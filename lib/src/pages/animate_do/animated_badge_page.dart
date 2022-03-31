import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class _NotificationsNotifier extends ValueNotifier<int> {
  _NotificationsNotifier({int value = 0}) : super(value);

  int oldValue = 0;

  //-Para actualizar el valor teniendo en cuenta el anterior, notar como es una funcion que recibe
  //-Otra funcion y esta tiene un argumento tipo int, devolvemos esta funcion pero con el argumento
  //-pasado desde aqui
  void update(int Function(int) callback) {
    if(callback(value) < 0) return;

    oldValue = value;

    value = callback(value);
  }
}

class AnimatedBadgePage extends StatefulWidget {
  const AnimatedBadgePage({Key? key}) : super(key: key);

  @override
  State<AnimatedBadgePage> createState() => _AnimatedBadgePageState();
}

class _AnimatedBadgePageState extends State<AnimatedBadgePage> {
  final _NotificationsNotifier _notificationNotifier = _NotificationsNotifier();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Animated Badge'),
      ),
      bottomNavigationBar: _BottomNavigation(
        onTap: (index) => print(index),
        notificationNotifier: _notificationNotifier,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () => _notificationNotifier.update((old) => old - 1),
            backgroundColor: Colors.pink,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 10.0),
          FloatingActionButton(
            heroTag: null,
            onPressed: () =>  _notificationNotifier.update((old) => old + 1),
            backgroundColor: Colors.pink,
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}

class _BottomNavigation extends StatefulWidget {
  final ValueChanged<int>? onTap;
  final _NotificationsNotifier notificationNotifier;

  const _BottomNavigation({Key? key, this.onTap, required this.notificationNotifier}) : super(key: key);

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
                  valueListenable: widget.notificationNotifier,
                  builder: (_, value, __) {
                    return Align(child: _AnimatedBadge(
                      currentCounter: value,
                      previousCounter: widget.notificationNotifier.oldValue,
                    ));
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
  final int previousCounter;
  final int currentCounter;

  const _AnimatedBadge({Key? key, this.currentCounter = 0, this.previousCounter = 0}) : super(key: key);

  @override
  __AnimatedBadgeState createState() => __AnimatedBadgeState();
}

class __AnimatedBadgeState extends State<_AnimatedBadge> with TickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _slideUp;
  late final Animation<double> _slideDown;

  static const _maxUpper = 8.0;
  static const _duration = 800;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
    );

    _slideUp = CurvedAnimation(
      parent: _controller, 
      curve: const Interval(0.00, 0.40)
    );

    _slideDown = CurvedAnimation(
      parent: _controller, 
      curve: const Interval(0.40, 1.00, curve: Curves.bounceOut)
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.currentCounter == 0) return const SizedBox.shrink();

    final counter = widget.currentCounter > 99 ? '99+' : widget.currentCounter.toString();

    if(widget.currentCounter < widget.previousCounter) {
      return _Badge(text: counter);
    }

    if(widget.currentCounter == 1) {
      return TweenAnimationBuilder<Offset>(
        tween: Tween(begin: const Offset(0.0, -_maxUpper), end: const Offset(0.0, 0.0)), 
        duration: const Duration(milliseconds: _duration ~/ 2), 
        curve: Curves.bounceOut,
        child: _Badge(text: counter),
        builder: (_, offset, child) => Transform.translate(offset: offset, child: child)
      );
    }

    _controller.forward(from: 0.0);

    return AnimatedBuilder(
      animation: _controller,
      child: _Badge(text: counter),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0.0, -_maxUpper * (_slideUp.value - _slideDown.value)),
          child: child,
        );
      },
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;

  const _Badge({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      padding: const EdgeInsets.all(4.0),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 10)
      ),
    );
  }
}

