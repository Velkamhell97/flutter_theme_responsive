import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PlayButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      clipBehavior: Clip.antiAlias,
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: onPressed, 
        icon: const Icon(Icons.play_arrow, color: Colors.white)
      ),
    );
  }
}