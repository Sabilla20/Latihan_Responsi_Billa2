import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/game.dart';

/// Library game milik user, disimpan dan dikelola dengan Hive.
/// Key = id game, value = Map data game.
class LibraryService {
  static const String _boxName = 'library';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

  static Box get _box => Hive.box(_boxName);

  /// Untuk ValueListenableBuilder agar UI otomatis ter-update.
  static ValueListenable<Box> listenable() => _box.listenable();

  static List<Game> getAll() => _box.values
      .map((e) => Game.fromMap(Map<dynamic, dynamic>.from(e as Map)))
      .toList();

  static int count() => _box.length;

  static bool contains(int id) => _box.containsKey(id);

  static Future<void> add(Game game) => _box.put(game.id, game.toMap());

  static Future<void> remove(int id) => _box.delete(id);
}
