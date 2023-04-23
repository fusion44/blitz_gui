//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'raw_debug_log_data.g.dart';

/// RawDebugLogData
///
/// Properties:
/// * [rawData] - The raw debug log text
/// * [githubIssuesUrl] - Link to the Raspiblitz issue tracker
abstract class RawDebugLogData
    implements Built<RawDebugLogData, RawDebugLogDataBuilder> {
  /// The raw debug log text
  @BuiltValueField(wireName: r'raw_data')
  String get rawData;

  /// Link to the Raspiblitz issue tracker
  @BuiltValueField(wireName: r'github_issues_url')
  String? get githubIssuesUrl;

  RawDebugLogData._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RawDebugLogDataBuilder b) =>
      b..githubIssuesUrl = 'https://www.github.com/rootzoll/raspiblitz/issues';

  factory RawDebugLogData([void updates(RawDebugLogDataBuilder b)]) =
      _$RawDebugLogData;

  @BuiltValueSerializer(custom: true)
  static Serializer<RawDebugLogData> get serializer =>
      _$RawDebugLogDataSerializer();
}

class _$RawDebugLogDataSerializer
    implements StructuredSerializer<RawDebugLogData> {
  @override
  final Iterable<Type> types = const [RawDebugLogData, _$RawDebugLogData];

  @override
  final String wireName = r'RawDebugLogData';

  @override
  Iterable<Object?> serialize(Serializers serializers, RawDebugLogData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'raw_data')
      ..add(serializers.serialize(object.rawData,
          specifiedType: const FullType(String)));
    if (object.githubIssuesUrl != null) {
      result
        ..add(r'github_issues_url')
        ..add(serializers.serialize(object.githubIssuesUrl,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  RawDebugLogData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = RawDebugLogDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'raw_data':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.rawData = valueDes;
          break;
        case r'github_issues_url':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.githubIssuesUrl = valueDes;
          break;
      }
    }
    return result.build();
  }
}
