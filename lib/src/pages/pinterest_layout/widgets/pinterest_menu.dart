import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PinterestButton {
  final IconData icon;
  final ValueChanged<int>? onPressed;

  const PinterestButton({required this.icon, this.onPressed});
}

class PinterestMenu extends StatefulWidget {
  final List<PinterestButton> buttons;
  final Color activeColor;
  final Color inactiveColor;

  const PinterestMenu({
    Key? key, 
    required this.buttons,
    this.activeColor = Colors.black,
    this.inactiveColor = Colors.grey,
  }) : super(key: key);

  @override
  State<PinterestMenu> createState() => _PinterestMenuState();
}

class _PinterestMenuState extends State<PinterestMenu> {
  final ValueNotifier<bool> _showBottomBarNotifier = ValueNotifier(true);
  final ValueNotifier<int> _optionNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _showBottomBarNotifier, 
      builder: (_, show, __) {
        return Stack(
          children: [
            NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if(notification.direction == ScrollDirection.reverse && show){
                  _showBottomBarNotifier.value = false;
                } else if(notification.direction == ScrollDirection.forward && !show){
                  _showBottomBarNotifier.value = true;
                }
  
                return true;
              },
              child: const _StaggeredGrid()
            ),
            Align(
              alignment: const Alignment(0.0, 0.95),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: show ? ValueListenableBuilder<int>(
                  valueListenable: _optionNotifier, 
                  builder: (_, current, __) {
                    return _BottomBar(
                      buttons: widget.buttons,
                      activeColor: widget.activeColor,
                      inactiveColor: widget.inactiveColor,
                      current: current,
                      onTap: (index) => _optionNotifier.value = index,
                    );
                  }
                ) : const SizedBox.shrink(),
              )
            )
          ],
        );
      }
    );
  }
}

class _StaggeredGrid extends StatelessWidget {
  const _StaggeredGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(5),
      child: StaggeredGrid.count(        
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: List.generate(30, (index) {
          return StaggeredGridTile.count(
            crossAxisCellCount: 2, 
            mainAxisCellCount: index.isOdd ? 3 : 2, 
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: Align(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('$index', style: const TextStyle(color: Colors.blue))
                  ),
                ),
              ),
            )
          );
        }),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final List<PinterestButton> buttons;
  final int current;
  final ValueChanged<int> onTap;
  final Color activeColor;
  final Color inactiveColor;

  const _BottomBar({
    Key? key, 
    required this.buttons, 
    required this.current, 
    required this.onTap,
    required this.activeColor,
    required this.inactiveColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Material(
      borderRadius: BorderRadius.circular(20.0),
      elevation: 10,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(buttons.length, (index) {
          final button = buttons[index];

          final color = index == current ? activeColor : inactiveColor;
          final scale = index == current ? 1.3 : 1.0;
  
          return Badge(
            showBadge: index == 2,
            badgeContent: const Text("9", style: TextStyle(color: Colors.white)),
            position: BadgePosition.topEnd(top: -5, end: -0),
            child: IconButton(
              onPressed:   () {
                if(button.onPressed != null){
                  button.onPressed!(index);
                }

                onTap(index);
              },
              splashRadius: 25, 
              icon: AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: scale,
                child: Icon(button.icon, color: color),
              )
            ),
          );
        }),
      ),
    );
  }
}