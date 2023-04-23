//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:blitz_api_client/src/model/api_platform.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'system_info.g.dart';

/// SystemInfo
///
/// Properties:
/// * [alias] - Name of the node (same as Lightning alias)
/// * [color] - The color of the current node in hex code format
/// * [platform] - The platform this API is running on.
/// * [platformVersion] - The version of this platform
/// * [apiVersion] - Version of the API software on this system.
/// * [torWebUi] - WebUI TOR address
/// * [torApi] - API TOR address
/// * [lanWebUi] - WebUI LAN address
/// * [lanApi] - API LAN address
/// * [sshAddress] - Address to ssh into on local LAN (e.g. `ssh admin@192.168.1.28`
/// * [chain] - The current chain this node is connected to (mainnet, testnet or signet)
/// * [codeVersion] - [RaspiBlitz only] The code version.
abstract class SystemInfo implements Built<SystemInfo, SystemInfoBuilder> {
  /// Name of the node (same as Lightning alias)
  @BuiltValueField(wireName: r'alias')
  String? get alias;

  /// The color of the current node in hex code format
  @BuiltValueField(wireName: r'color')
  String get color;

  /// The platform this API is running on.
  @BuiltValueField(wireName: r'platform')
  APIPlatform? get platform;

  /// The version of this platform
  @BuiltValueField(wireName: r'platform_version')
  String? get platformVersion;

  /// Version of the API software on this system.
  @BuiltValueField(wireName: r'api_version')
  String get apiVersion;

  /// WebUI TOR address
  @BuiltValueField(wireName: r'tor_web_ui')
  String? get torWebUi;

  /// API TOR address
  @BuiltValueField(wireName: r'tor_api')
  String? get torApi;

  /// WebUI LAN address
  @BuiltValueField(wireName: r'lan_web_ui')
  String? get lanWebUi;

  /// API LAN address
  @BuiltValueField(wireName: r'lan_api')
  String? get lanApi;

  /// Address to ssh into on local LAN (e.g. `ssh admin@192.168.1.28`
  @BuiltValueField(wireName: r'ssh_address')
  String get sshAddress;

  /// The current chain this node is connected to (mainnet, testnet or signet)
  @BuiltValueField(wireName: r'chain')
  String get chain;

  /// [RaspiBlitz only] The code version.
  @BuiltValueField(wireName: r'code_version')
  String? get codeVersion;

  SystemInfo._();

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SystemInfoBuilder b) => b
    ..alias = ''
    ..platformVersion = ''
    ..torWebUi = ''
    ..torApi = ''
    ..lanWebUi = ''
    ..lanApi = ''
    ..codeVersion = '';

  factory SystemInfo([void updates(SystemInfoBuilder b)]) = _$SystemInfo;

  @BuiltValueSerializer(custom: true)
  static Serializer<SystemInfo> get serializer => _$SystemInfoSerializer();
}

class _$SystemInfoSerializer implements StructuredSerializer<SystemInfo> {
  @override
  final Iterable<Type> types = const [SystemInfo, _$SystemInfo];

  @override
  final String wireName = r'SystemInfo';

  @override
  Iterable<Object?> serialize(Serializers serializers, SystemInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    if (object.alias != null) {
      result
        ..add(r'alias')
        ..add(serializers.serialize(object.alias,
            specifiedType: const FullType(String)));
    }
    result
      ..add(r'color')
      ..add(serializers.serialize(object.color,
          specifiedType: const FullType(String)));
    if (object.platform != null) {
      result
        ..add(r'platform')
        ..add(serializers.serialize(object.platform,
            specifiedType: const FullType.nullable(APIPlatform)));
    }
    if (object.platformVersion != null) {
      result
        ..add(r'platform_version')
        ..add(serializers.serialize(object.platformVersion,
            specifiedType: const FullType(String)));
    }
    result
      ..add(r'api_version')
      ..add(serializers.serialize(object.apiVersion,
          specifiedType: const FullType(String)));
    if (object.torWebUi != null) {
      result
        ..add(r'tor_web_ui')
        ..add(serializers.serialize(object.torWebUi,
            specifiedType: const FullType(String)));
    }
    if (object.torApi != null) {
      result
        ..add(r'tor_api')
        ..add(serializers.serialize(object.torApi,
            specifiedType: const FullType(String)));
    }
    if (object.lanWebUi != null) {
      result
        ..add(r'lan_web_ui')
        ..add(serializers.serialize(object.lanWebUi,
            specifiedType: const FullType(String)));
    }
    if (object.lanApi != null) {
      result
        ..add(r'lan_api')
        ..add(serializers.serialize(object.lanApi,
            specifiedType: const FullType(String)));
    }
    result
      ..add(r'ssh_address')
      ..add(serializers.serialize(object.sshAddress,
          specifiedType: const FullType(String)));
    result
      ..add(r'chain')
      ..add(serializers.serialize(object.chain,
          specifiedType: const FullType(String)));
    if (object.codeVersion != null) {
      result
        ..add(r'code_version')
        ..add(serializers.serialize(object.codeVersion,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  SystemInfo deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = SystemInfoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;

      switch (key) {
        case r'alias':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.alias = valueDes;
          break;
        case r'color':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.color = valueDes;
          break;
        case r'platform':
          final valueDes = serializers.deserialize(value,
                  specifiedType: const FullType.nullable(APIPlatform))
              as APIPlatform?;
          if (valueDes == null) continue;
          result.platform = valueDes;
          break;
        case r'platform_version':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.platformVersion = valueDes;
          break;
        case r'api_version':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.apiVersion = valueDes;
          break;
        case r'tor_web_ui':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.torWebUi = valueDes;
          break;
        case r'tor_api':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.torApi = valueDes;
          break;
        case r'lan_web_ui':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.lanWebUi = valueDes;
          break;
        case r'lan_api':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.lanApi = valueDes;
          break;
        case r'ssh_address':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.sshAddress = valueDes;
          break;
        case r'chain':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.chain = valueDes;
          break;
        case r'code_version':
          final valueDes = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          result.codeVersion = valueDes;
          break;
      }
    }
    return result.build();
  }
}
