import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;
import '../models/alarm.dart';
import '../models/timezone.dart';
import 'dart:convert';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'alarm_clock.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
      onUpgrade: _upgradeDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    // Create alarms table
    await db.execute('''
      CREATE TABLE alarms (
        id TEXT PRIMARY KEY,
        hour INTEGER NOT NULL,
        minute INTEGER NOT NULL,
        label TEXT,
        enabled INTEGER NOT NULL,
        repeatDays TEXT,
        sound TEXT,
        snoozeDuration INTEGER,
        autoSilentTime INTEGER,
        createdAt TEXT NOT NULL,
        lastTriggeredAt TEXT
      )
    ''');

    // Create timezones table
    await db.execute('''
      CREATE TABLE timezones (
        id TEXT PRIMARY KEY,
        location TEXT NOT NULL,
        timeZoneName TEXT NOT NULL,
        displayName TEXT NOT NULL,
        country TEXT,
        utcOffset INTEGER,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  Future<void> _upgradeDatabase(Database db, int oldVersion, int newVersion) async {
    // Handle future schema migrations here
  }

  // Alarm operations
  Future<void> insertAlarm(Alarm alarm) async {
    final db = await database;
    await db.insert(
      'alarms',
      {
        'id': alarm.id,
        'hour': alarm.hour,
        'minute': alarm.minute,
        'label': alarm.label,
        'enabled': alarm.enabled ? 1 : 0,
        'repeatDays': jsonEncode(alarm.repeatDays),
        'sound': alarm.sound,
        'snoozeDuration': alarm.snoozeDuration,
        'autoSilentTime': alarm.autoSilentTime,
        'createdAt': alarm.createdAt.toIso8601String(),
        'lastTriggeredAt': alarm.lastTriggeredAt?.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateAlarm(Alarm alarm) async {
    final db = await database;
    await db.update(
      'alarms',
      {
        'hour': alarm.hour,
        'minute': alarm.minute,
        'label': alarm.label,
        'enabled': alarm.enabled ? 1 : 0,
        'repeatDays': jsonEncode(alarm.repeatDays),
        'sound': alarm.sound,
        'snoozeDuration': alarm.snoozeDuration,
        'autoSilentTime': alarm.autoSilentTime,
        'lastTriggeredAt': alarm.lastTriggeredAt?.toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [alarm.id],
    );
  }

  Future<void> deleteAlarm(String id) async {
    final db = await database;
    await db.delete('alarms', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Alarm>> getAllAlarms() async {
    final db = await database;
    final maps = await db.query('alarms', orderBy: 'hour ASC, minute ASC');
    return List.generate(maps.length, (i) => _mapToAlarm(maps[i]));
  }

  Future<Alarm?> getAlarmById(String id) async {
    final db = await database;
    final maps = await db.query('alarms', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return _mapToAlarm(maps.first);
  }

  Alarm _mapToAlarm(Map<String, dynamic> map) {
    return Alarm(
      id: map['id'],
      hour: map['hour'],
      minute: map['minute'],
      label: map['label'] ?? 'Wake up',
      enabled: map['enabled'] == 1,
      repeatDays: List<int>.from(jsonDecode(map['repeatDays'] ?? '[]')),
      sound: map['sound'] ?? 'Constellation',
      snoozeDuration: map['snoozeDuration'] ?? 5,
      autoSilentTime: map['autoSilentTime'] ?? 15,
      createdAt: DateTime.parse(map['createdAt']),
      lastTriggeredAt: map['lastTriggeredAt'] != null ? DateTime.parse(map['lastTriggeredAt']) : null,
    );
  }

  // TimeZone operations
  Future<void> insertTimeZone(TimeZoneItem timeZone) async {
    final db = await database;
    await db.insert(
      'timezones',
      {
        'id': timeZone.id,
        'location': timeZone.location,
        'timeZoneName': timeZone.timeZoneName,
        'displayName': timeZone.displayName,
        'country': timeZone.country,
        'utcOffset': timeZone.utcOffset,
        'createdAt': timeZone.createdAt.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTimeZone(TimeZoneItem timeZone) async {
    final db = await database;
    await db.update(
      'timezones',
      {
        'location': timeZone.location,
        'timeZoneName': timeZone.timeZoneName,
        'displayName': timeZone.displayName,
        'country': timeZone.country,
        'utcOffset': timeZone.utcOffset,
      },
      where: 'id = ?',
      whereArgs: [timeZone.id],
    );
  }

  Future<void> deleteTimeZone(String id) async {
    final db = await database;
    await db.delete('timezones', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<TimeZoneItem>> getAllTimeZones() async {
    final db = await database;
    final maps = await db.query('timezones', orderBy: 'createdAt DESC');
    return List.generate(maps.length, (i) => _mapToTimeZone(maps[i]));
  }

  Future<TimeZoneItem?> getTimeZoneById(String id) async {
    final db = await database;
    final maps = await db.query('timezones', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return _mapToTimeZone(maps.first);
  }

  TimeZoneItem _mapToTimeZone(Map<String, dynamic> map) {
    return TimeZoneItem(
      id: map['id'],
      location: map['location'],
      timeZoneName: map['timeZoneName'],
      displayName: map['displayName'],
      country: map['country'],
      utcOffset: map['utcOffset'] ?? 0,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  // Close database
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
