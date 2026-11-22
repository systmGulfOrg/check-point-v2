import 'dart:convert';
import 'app_database.dart';

class CacheManager {
  final AppDatabase db;

  CacheManager({required this.db});

  Future<void> put(String key, String json) async {
    await db
        .into(db.cacheEntries)
        .insertOnConflictUpdate(
          CacheEntriesCompanion.insert(
            key: key,
            json: json,
            updatedAt: DateTime.now().toUtc(),
          ),
        );
  }

  Future<String?> get(String key) async {
    final entry = await (db.select(
      db.cacheEntries,
    )..where((tbl) => tbl.key.equals(key))).getSingleOrNull();
    return entry?.json;
  }

  Future<void> putJson(String key, dynamic data) async {
    await put(key, jsonEncode(data));
  }

  Future<dynamic> getJson(String key) async {
    final raw = await get(key);
    if (raw == null || raw.isEmpty) return null;
    try {
      return jsonDecode(raw);
    } catch (_) {
      return null;
    }
  }

  Future<void> clearAll() async {
    await db.delete(db.cacheEntries).go();
  }
}
