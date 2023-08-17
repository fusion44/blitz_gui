import 'dart:math' as math;

import 'package:flutter/material.dart';

class ContainerChipWidget extends StatefulWidget {
  final String imageAssetName;
  final double? imageScale;
  final double? chipWidth;
  final double chipHeight;
  final String tooltip;

  const ContainerChipWidget(
    this.imageAssetName, {
    super.key,
    this.imageScale,
    this.chipWidth,
    this.chipHeight = 39,
    this.tooltip = '',
  });

  @override
  State<ContainerChipWidget> createState() => _ContainerChipWidgetState();
}

class _ContainerChipWidgetState extends State<ContainerChipWidget> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => hovered = true),
        onExit: (_) => setState(() => hovered = false),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          child: Container(
            key: hovered
                ? Key('cntr_chip_${math.Random().nextInt(99999999)}_in')
                : Key('cntr_chip_${math.Random().nextInt(99999999)}_out'),
            width: widget.chipWidth,
            height: widget.chipHeight,
            decoration: _buildBoxDecoration(hovered, theme),
            child: Image.asset(widget.imageAssetName, scale: widget.imageScale),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration(bool hovered, ThemeData theme) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.black54, width: 1),
      color: hovered ? theme.cardColor.withBlue(120) : theme.cardColor,
    );
  }
}
