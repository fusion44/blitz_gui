library sendmany.utils;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;

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

int? forceInt(dynamic source) {
  if (source is int) {
    return source;
  } else if (source is double) {
    return source.floor();
  } else if (source is String) {
    return int.tryParse(source);
  }
}

double? forceDouble(dynamic source) {
  if (source is double) {
    return source;
  } else if (source is int) {
    return source.toDouble();
  } else if (source is String) {
    return double.tryParse(source);
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
