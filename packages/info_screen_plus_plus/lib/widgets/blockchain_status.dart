// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:common/common.dart';

class BlockchainStatus extends StatefulWidget {
  final BitcoinInfo info;
  const BlockchainStatus({Key? key, required this.info}) : super(key: key);

  @override
  _BlockchainStatusState createState() => _BlockchainStatusState();
}

class _BlockchainStatusState extends State<BlockchainStatus> {
  @override
  Widget build(BuildContext context) {
    final i = widget.info;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildBlockRow(constraints.maxWidth, i),
            )
          ],
        );
      },
    );
  }

  Widget _buildBlockRow(double maxWidth, BitcoinInfo i) {
    if (maxWidth < 300) {
      return BlockchainBlockRow(
        sideLength: 50.0,
        currentBlockHeight: i.blocks,
        onTap: (p0) => debugPrint(p0.toString()),
      );
    } else {
      return BlockchainBlockRow(
        currentBlockHeight: i.blocks,
        onTap: (p0) => debugPrint(p0.toString()),
      );
    }
  }
}
