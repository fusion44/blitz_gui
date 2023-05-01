library sendmany.utils;

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;

import 'constants.dart';

extension StringExtensions on String {
  /// Inserts a character into the string at the specified position.
  ///
  /// If [pos] is negative, the character is inserted from the end of the string.
  ///
  /// Throws a [RangeError] if the [pos] is out of bounds of the original string.
  insertCharAtPosition(int pos, String char) {
    int length = this.length;
    if (pos < -length - 1 || pos > length) {
      throw RangeError("Position is out of bounds of the original string");
    }

    if (pos < 0) {
      pos = length + pos;
    }

    return substring(0, pos) + char + substring(pos);
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

bool forceBool(dynamic source, {int defaultValue = 0}) {
  if (source is bool) {
    return source;
  } else if (source is int && source == 0 ||
      source is String && source == '0') {
    return false;
  } else if (source is int && source == 1 ||
      source is String && source == '1') {
    return true;
  } else {
    final val = source ?? 'Source null';
    throw FormatException('$val is not a bool');
  }
}

int forceInt(dynamic source, {int defaultValue = 0}) {
  if (source is int) {
    return source;
  } else if (source is double) {
    return source.floor();
  } else if (source is String) {
    return int.tryParse(source) ?? defaultValue;
  } else {
    return defaultValue;
  }
}

String forceString(dynamic source, {String defaultValue = ''}) {
  if (source == null) {
    return defaultValue;
  } else if (source == String) {
    return source;
  } else {
    return source.toString();
  }
}

double forceDouble(dynamic source, {double defaultValue = 0.0}) {
  if (source is double) {
    return source;
  } else if (source is int) {
    return source.toDouble();
  } else if (source is String) {
    return double.tryParse(source) ?? defaultValue;
  } else {
    return defaultValue;
  }
}

Future<http.Response> fetch(Uri uri, String token) async =>
    await http.get(uri, headers: {'Authorization': token});

Future<http.Response> post(
  Uri uri,
  String token,
  dynamic body, {
  Map<String, String> headers = const {},
}) async {
  final newHeaders = {...headers};
  if (token.isNotEmpty) {
    newHeaders['Authorization'] = token;
  }

  if (!headers.containsKey('Content-Type')) {
    newHeaders['accept'] = 'application/json';
    newHeaders['Content-Type'] = 'application/json';
  }

  try {
    final resp = await http.post(
      uri,
      headers: newHeaders,
      body: jsonEncode(body),
    );

    return resp;
  } catch (e) {
    rethrow;
  }
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

class TabPageData {
  final String id;
  final String label;
  final IconData icon;

  TabPageData(this.id, this.label, this.icon);
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
