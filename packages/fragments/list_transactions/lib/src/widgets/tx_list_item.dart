import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TxListItem extends StatelessWidget {
  const TxListItem({Key? key, required this.tx}) : super(key: key);

  final Transaction tx;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${tx.index}'),
      title: Text(tx.category),
    );
  }
}
