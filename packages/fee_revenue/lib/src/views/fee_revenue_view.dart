import 'package:flutter/material.dart';

import 'package:common_blocs/common_blocs.dart';
import 'package:common_widgets/common_widgets.dart';
import 'package:fee_revenue_fragment/src/widgets/fee_revenue_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeeRevenueView extends StatelessWidget {
  const FeeRevenueView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => FeeRevenueCubit(
        RepositoryProvider.of<FeeRevenueRepository>(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TrText(
            'lightning.forwarding_fees',
            style: theme.textTheme.headlineSmall!.copyWith(
              color: blitzHeaderTextColor,
            ),
          ),
          const SizedBox(height: 8.0),
          const FeeRevenueWidget(),
        ],
      ),
    );
  }
}
