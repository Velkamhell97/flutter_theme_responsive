import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class BasicAnimationsHome extends StatelessWidget {
  const BasicAnimationsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final landscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: landscape ? null : AppBar(title: const Text('Basic Animations App')),
      body: ListView(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height * 0.15
            ),
            child: const RotationWidget(
              // reset: true
            )
          ),
          const Divider(thickness: 1),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height * 0.15
            ),
            child: const FadeRotationWidget(
              // reset: true
            )
          ),
          const Divider(thickness: 1),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height * 0.15
            ),
            child: const RotationSlideWidget(
              // reset: true
            )
          ),
          const Divider(thickness: 1),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height * 0.15
            ),
            child: const ScaleRotationWidget(
              // reset: true
            )
          ),
          const Divider(thickness: 1),
        ],
      ),
    );
  }
}