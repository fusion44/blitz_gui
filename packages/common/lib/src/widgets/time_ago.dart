import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';

class TimeAgoText extends StatelessWidget {
  final DateTime _date;
  final String _langCode;
  final bool allowFromNow;

  final TextStyle? style;
  final TextOverflow? overflow;
  final bool? softWrap;

  const TimeAgoText(
    this._date,
    this._langCode, {
    Key? key,
    this.allowFromNow = true,
    this.style,
    this.overflow,
    this.softWrap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formatted = format(
      _date,
      allowFromNow: allowFromNow,
      locale: _langCode,
    );
    return Text(
      formatted,
      style: style,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
