import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart';

import '../../blocs/settings_bloc/settings_bloc.dart';

class TimeAgoText extends StatelessWidget {
  final bool allowFromNow;
  final DateTime date;
  final TextStyle? style;
  final TextOverflow? overflow;
  final bool? softWrap;

  const TimeAgoText(
    this.date, {
    Key? key,
    this.allowFromNow = true,
    this.style,
    this.overflow,
    this.softWrap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<SettingsBloc>(context),
      builder: (BuildContext context, SettingsBaseState state) {
        var formatted = format(
          date,
          allowFromNow: allowFromNow,
          locale: state.langCode,
        );
        return Text(
          formatted,
          style: style,
          overflow: overflow,
          softWrap: softWrap,
        );
      },
    );
  }
}
