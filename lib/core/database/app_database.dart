import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class CacheEntries extends Table {
  TextColumn get key => text()();
  TextColumn get json => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {key};
}

class PendingAttendanceTable extends Table {
  TextColumn get clientUuid => text()();
  TextColumn get type => text()(); // 'in' | 'out'
  DateTimeColumn get wallClock => dateTime()();
  Int64Column get monotonicMs => int64()();
  TextColumn get bootId => text()();
  DateTimeColumn get anchorServerTime => dateTime().nullable()();
  Int64Column get anchorMonotonicMs => int64().nullable()();
  TextColumn get anchorBootId => text().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  RealColumn get accuracyM => real().nullable()();
  TextColumn get area => text().nullable()();
  TextColumn get customerId => text().nullable()();
  BoolColumn get mockLocationDetected => boolean().withDefault(const Constant(false))();
  TextColumn get status => text().withDefault(const Constant('queued'))();
  TextColumn get reason => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {clientUuid};
}

class TimeAnchors extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get serverTime => dateTime()();
  Int64Column get monotonicMs => int64()();
  TextColumn get bootId => text()();
  DateTimeColumn get recordedAt => dateTime()();
}

@DriftDatabase(tables: [CacheEntries, PendingAttendanceTable, TimeAnchors])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'checkpoint_app.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
