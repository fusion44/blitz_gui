import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BitcoinBlockSimple extends StatelessWidget {
  final Function(int)? onTap;
  final double sideLength;
  final int blockHeight;
  final double cornerRadius;

  const BitcoinBlockSimple({
    this.sideLength = 80.0,
    this.blockHeight = 0,
    this.cornerRadius = 10.0,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text =
        blockHeight != 0 ? blockHeight.toString() : 'TODO:\nmempool info';

    return InkWell(
      onTap: onTap != null ? () => onTap!(blockHeight) : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius),
        child: Container(
          width: sideLength,
          height: sideLength,
          color: blockHeight > 0 ? Colors.red : Colors.amber[600],
          child: sideLength > 25
              ? Center(
                  child: AutoSizeText(
                    text,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: sideLength >= 80
                        ? theme.textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.bold,
                          )
                        : null,
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
