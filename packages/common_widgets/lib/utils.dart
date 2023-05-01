import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'constants.dart';

/// Updates the time ago library with the current language
void updateTimeAgoLib(String lang) {
  if (lang == 'de') {
    timeago.setLocaleMessages(lang, timeago.DeMessages());
  } else if (lang == 'nb') {
    timeago.setLocaleMessages('nb', timeago.NbNoMessages());
  } else {
    timeago.setLocaleMessages(lang, timeago.EnMessages());
  }
}

/// Translates a string with the given [key] and the [args].
String tr(String key, [Map<String, dynamic> args = const <String, dynamic>{}]) {
  return translate(key, args: args);
}

/// Plurally translates a string with the given [key] and the [value].
String trp(
  String key,
  num value, [
  Map<String, dynamic> args = const <String, dynamic>{},
]) {
  return translatePlural(key, value, args: args);
}

List<Widget> buildAnimatedVerticalColumnChildren(List<Widget> children) {
  return AnimationConfiguration.toStaggeredList(
    duration: defaultListItemAnimationSpeed,
    childAnimationBuilder: (widget) => SlideAnimation(
      verticalOffset: defaultListItemVerticalOffset,
      horizontalOffset: defaultListItemHorizontalOffset,
      child: FadeInAnimation(
        child: widget,
      ),
    ),
    children: children,
  );
}

class TabPageData {
  final String id;
  final String label;
  final IconData icon;

  TabPageData(this.id, this.label, this.icon);
}

/// Returns the full language name of the provided language code
LanguageDisplayData getLanguageCodeDisplayData(String code) {
  switch (code) {
    case 'de':
      return LanguageDisplayData(
        'German',
        Image.asset('assets/flags/de.png'),
      );
    case 'en':
      return LanguageDisplayData(
        'English',
        Image.asset('assets/flags/gb.png'),
      );
    case 'nb':
      return LanguageDisplayData(
        'Norwegian Bokmål',
        Image.asset('assets/flags/no.png'),
      );
    default:
      throw UnsupportedError('Language "$code" is not yet supported.');
  }
}

class LanguageDisplayData {
  final String name;
  final Image flag;

  LanguageDisplayData(this.name, this.flag);
}

TextTheme buildTextThemeWithEczar(
  TextTheme base, {
  double fontSize = 32,
  double height = 1.2,
}) {
  return base
      .copyWith(
        bodyMedium: base.bodyMedium?.copyWith(
          fontSize: fontSize,
          height: height,
        ),
      )
      .apply(fontFamily: 'Eczar');
}
