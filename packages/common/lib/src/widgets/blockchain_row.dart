import 'package:flutter/material.dart';

import 'blockchain_block_simple.dart';

class BlockchainBlockRow extends StatelessWidget {
  final Function(int)? onTap;
  final double sideLength;
  final int currentBlockHeight;
  final double spacing;
  final double dividerThickness;
  final double cornerRadius;

  const BlockchainBlockRow({
    Key? key,
    required this.currentBlockHeight,
    this.sideLength = 80.0,
    this.spacing = 7.0,
    this.dividerThickness = 2.0,
    this.cornerRadius = 10.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        int numBlocks = constraints.maxWidth ~/ sideLength;

        final blocks = [];
        final leftOffset = sideLength + dividerThickness + 2 * spacing;

        for (var i = 0; i < numBlocks + 1; i++) {
          blocks.add(
            Positioned(
              left: i * sideLength + i * spacing + leftOffset,
              child: BitcoinBlockSimple(
                sideLength: sideLength,
                blockHeight: currentBlockHeight - i,
                cornerRadius: cornerRadius,
                onTap: onTap,
              ),
            ),
          );
        }
        blocks.remove(blocks.last);

        return SizedBox(
          height: sideLength,
          width: double.infinity,
          child: Stack(
            children: [
              BitcoinBlockSimple(
                cornerRadius: cornerRadius,
                onTap: onTap,
                sideLength: sideLength,
              ),
              Positioned(
                top: 10,
                left: sideLength + spacing,
                child: Container(
                  height: sideLength - 20,
                  width: dividerThickness,
                  color: theme.textTheme.bodyText1?.color,
                ),
              ),
              ...blocks
            ],
          ),
        );
      },
    );
  }
}
