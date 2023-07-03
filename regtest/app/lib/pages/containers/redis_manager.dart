import 'package:regtest_core/core.dart';

class RedisManager {
  bool _isInitialized = false;
  int _dbCounter = 0;

  static final RedisManager _instance = RedisManager._internal();

  factory RedisManager() => _instance;

  late final RedisContainer? _redisContainer;

  RedisManager._internal();

  RedisContainer get mainRedis {
    if (!_isInitialized) throw StateError("RedisManager not initialized");

    return _redisContainer!;
  }

  int get dbCounter => _dbCounter++;

  /// Creates or starts a Redis default container used within the app
  Future<void> init() async {
    if (_isInitialized) {
      return;
    }

    final res = NetworkManager().findFirstOf<RedisContainer>();

    if (res == null) {
      // We haven't found a reusable Redis container, start a new one
      final c = NetworkManager().createContainer(
        ContainerType.redis,
        opts: const RedisOptions(name: 'app_redis'),
      );

      await NetworkManager().startContainer(c.internalId);

      _redisContainer = c as RedisContainer;
      _isInitialized = true;

      return;
    }

    if (!res.running) await NetworkManager().startContainer(res.dockerId);

    if (!res.running) {
      throw StateError(
        'Found a Redis container but it is not running and the attempt to start it failed. Docker ID: ${res.dockerId}',
      );
    }

    _isInitialized = true;
  }
}
