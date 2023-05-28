import 'package:flutter/material.dart';

class NodeTestContents extends StatelessWidget {
  final String header;
  final String body;
  final String footer;

  const NodeTestContents({
    super.key,
    required this.header,
    required this.body,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.lightGreen,
            child: Text(
              header,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blueGrey,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const InkWell(
                      child: Icon(Icons.drag_handle),
                    ),
                  ),
                  Expanded(child: Text(body)),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.amberAccent,
            child: Text(
              footer,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
