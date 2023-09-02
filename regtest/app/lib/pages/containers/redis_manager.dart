import 'dart:async';

import 'package:regtest_core/core.dart';
import 'package:stash/stash_api.dart';
import 'package:stash_file/stash_file.dart';

class RedisManager {
  // Singleton stuff
  static final RedisManager _instance = RedisManager._internal();
  factory RedisManager() => _instance;
  late final RedisContainer? _redisContainer;
  RedisManager._internal();

  // RedisManager
  bool _isInitialized = false;
  int _dbCounter = 0;
  final Map<String, int> _dbCounterMap = {};
  late final Vault _vault;

  RedisContainer get mainRedis {
    if (!_isInitialized) throw StateError("RedisManager not initialized");

    return _redisContainer!;
  }

  /// Creates or starts a Redis default container used within the app
  Future<void> init() async {
    if (_isInitialized) {
      return;
    }

    final res = NetworkManager().findFirstOf<RedisContainer>();

    await _initVault();

    if (NetworkManager().containers.length < 2) {
      // A very crude way of resetting the Redis counter
      // If we are here it means no Redis or only Redis is running and
      // it is safe to reset.
      await _clearVault();
    }

    if (res == null) {
      // We haven't found a reusable Redis container, start a new one
      final c = await NetworkManager().createContainer(
        ContainerType.redis,
        opts: RedisOptions(),
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

    _redisContainer = res;
    _isInitialized = true;
  }

  int generateDbId(String key) {
    if (!_isInitialized) throw StateError("RedisManager not initialized");

    if (_dbCounterMap.containsKey(key)) return _dbCounterMap[key]!;

    _dbCounterMap[key] = _dbCounter;
    _dbCounter++;
    _vault.put(key, _dbCounter);

    return _dbCounterMap[key]!;
  }

  Future<void> _initVault() async {
    final store = await newFileLocalVaultStore(path: 'vaults');
    _vault = await store.vault(name: 'redis_db_ids');

    final keys = await _vault.keys;
    final values = await _vault.getAll(keys.toSet());

    for (var id in values.keys) {
      final val = values[id];
      _dbCounterMap[id] = val;
      if (_dbCounter <= val) _dbCounter = val + 1;
    }
  }

  Future<void> _clearVault() async {
    await _vault.clear();
    _dbCounter = 0;
    _dbCounterMap.clear();
  }
}
