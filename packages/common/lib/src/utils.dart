library sendmany.utils;

import 'dart:convert';

import 'package:http/http.dart' as http;

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
