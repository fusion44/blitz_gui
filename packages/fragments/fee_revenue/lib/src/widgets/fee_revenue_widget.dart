import 'package:flutter/material.dart';

import 'package:common/common.dart';
import 'package:common_blocs/common_blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FeeRevenueWidget extends StatelessWidget {
  const FeeRevenueWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<FeeRevenueCubit>(context),
      builder: (context, state) {
        if (state is FeeRevenueUpdated) {
          final format = NumberFormat.compact(locale: 'en');

          return Row(
            children: [
              DataItem(
                text: format.format(state.data.day),
                label: 'lightning.fee_revenue_daily',
                showSatSymbol: true,
                showNotificationContainer: false,
              ),
              const SizedBox(width: 8.0),
              DataItem(
                text: format.format(state.data.week + 5125),
                label: 'lightning.fee_revenue_weekly',
                showSatSymbol: true,
                showNotificationContainer: false,
              ),
              const SizedBox(width: 8.0),
              DataItem(
                text: format.format(state.data.month + 152123),
                label: 'lightning.fee_revenue_monthly',
                showSatSymbol: true,
                showNotificationContainer: false,
              ),
            ],
          );
        }

        return const Text('loading');
      },
    );
  }
}
