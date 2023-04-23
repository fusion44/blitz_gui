//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/htlc_attempt_failure.dart';
import 'package:blitz_api_client/src/model/htlc_status.dart';
import 'package:blitz_api_client/src/model/route.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'htlc_attempt.g.dart';

/// HTLCAttempt
///
/// Properties:
/// * [attemptId]
/// * [status]
/// * [route]
/// * [attemptTimeNs]
/// * [resolveTimeNs]
/// * [failure]
/// * [preimage]
abstract class HTLCAttempt implements Built<HTLCAttempt, HTLCAttemptBuilder> {
  @BuiltValueField(wireName: r'attempt_id')
  int get attemptId;

  @BuiltValueField(wireName: r'status')
  HTLCStatus get status;
  // enum statusEnum {  in_flight,  succeeded,  failed,  };

  @BuiltValueField(wireName: r'route')
  Route get route;

  @BuiltValueField(wireName: r'attempt_time_ns')
  int get attemptTimeNs;

  @BuiltValueField(wireName: r'resolve_time_ns')
  int get resolveTimeNs;

  @BuiltValueField(wireName: r'failure')
  HTLCAttemptFailure get failure;

  @BuiltValueField(wireName: r'preimage')
  String get preimage;

  HTLCAttempt._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HTLCAttemptBuilder b) => b;

  factory HTLCAttempt([void updates(HTLCAttemptBuilder b)]) = _$HTLCAttempt;

  @BuiltValueSerializer(custom: true)
  static Serializer<HTLCAttempt> get serializer => _$HTLCAttemptSerializer();
}

class _$HTLCAttemptSerializer implements StructuredSerializer<HTLCAttempt> {
  @override
  final Iterable<Type> types = const [HTLCAttempt, _$HTLCAttempt];

  @override
  final String wireName = r'HTLCAttempt';

  @override
  Iterable<Object?> serialize(Serializers serializers, HTLCAttempt object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    result
      ..add(r'attempt_id')
      ..add(serializers.serialize(object.attemptId,
          specifiedType: const FullType(int)));
    result
      ..add(r'status')
      ..add(serializers.serialize(object.status,
          specifiedType: const FullType(HTLCStatus)));
    result
      ..add(r'route')
      ..add(serializers.serialize(object.route,
          specifiedType: const FullType(Route)));
    result
      ..add(r'attempt_time_ns')
      ..add(serializers.serialize(object.attemptTimeNs,
          specifiedType: const FullType(int)));
    result
      ..add(r'resolve_time_ns')
      ..add(serializers.serialize(object.resolveTimeNs,
          specifiedType: const FullType(int)));
    result
      ..add(r'failure')
      ..add(serializers.serialize(object.failure,
          specifiedType: const FullType(HTLCAttemptFailure)));
    result
      ..add(r'preimage')
      ..add(serializers.serialize(object.preimage,
          specifiedType: const FullType(String)));
    return result;
  }

  @override
  HTLCAttempt deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = HTLCAttemptBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'attempt_id':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.attemptId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(HTLCStatus)) as HTLCStatus;
          result.status = valueDes;
          break;
        case r'route':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(Route)) as Route;
          result.route.replace(valueDes);
          break;
        case r'attempt_time_ns':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.attemptTimeNs = valueDes;
          break;
        case r'resolve_time_ns':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          result.resolveTimeNs = valueDes;
          break;
        case r'failure':
          final valueDes = serializers.deserialize(value,
                  specifiedType: const FullType(HTLCAttemptFailure))
              as HTLCAttemptFailure;
          result.failure.replace(valueDes);
          break;
        case r'preimage':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.preimage = valueDes;
          break;
      }
    }
    return result.build();
  }
}
