import 'package:flutter/material.dart';

import 'package:fee_revenue_fragment/fee_revenue.dart';

class BigScreenDashboard extends StatelessWidget {
  const BigScreenDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: const [
          FeeRevenueView(),
        ],
      ),
    );
  }
}
