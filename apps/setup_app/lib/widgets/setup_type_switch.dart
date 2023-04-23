import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SetupTypeSwitch extends StatelessWidget {
  final int crossAxisCount;
  final List<Widget> buttons;

  const SetupTypeSwitch(this.crossAxisCount, this.buttons, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450,
      child: GridView.count(
        primary: true,
        shrinkWrap: true,
        crossAxisCount: crossAxisCount,
        children: List.generate(
          buttons.length,
          (int index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 375),
              columnCount: crossAxisCount,
              child: ScaleAnimation(
                child: FadeInAnimation(child: buttons[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
