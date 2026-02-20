import 'package:uuid/uuid.dart';
import '../models/timezone.dart';
import 'database_service.dart';

class TimeZoneService {
  final DatabaseService _db = DatabaseService();

  // Create new timezone
  Future<TimeZoneItem> addTimeZone({
    required String location,
    required String timeZoneName,
    required String displayName,
    String? country,
    int utcOffset = 0,
  }) async {
    const uuid = Uuid();
    final timeZone = TimeZoneItem(
      id: uuid.v4(),
      location: location,
      timeZoneName: timeZoneName,
      displayName: displayName,
      country: country,
      utcOffset: utcOffset,
    );

    await _db.insertTimeZone(timeZone);
    return timeZone;
  }

  // Get all timezones
  Future<List<TimeZoneItem>> getAllTimeZones() async {
    return await _db.getAllTimeZones();
  }

  // Get timezone by ID
  Future<TimeZoneItem?> getTimeZoneById(String id) async {
    return await _db.getTimeZoneById(id);
  }

  // Update timezone
  Future<void> updateTimeZone(TimeZoneItem timeZone) async {
    await _db.updateTimeZone(timeZone);
  }

  // Delete timezone
  Future<void> deleteTimeZone(String id) async {
    await _db.deleteTimeZone(id);
  }

  // Get timezone by name
  Future<TimeZoneItem?> getTimeZoneByName(String name) async {
    final all = await _db.getAllTimeZones();
    try {
      return all.firstWhere((tz) => tz.timeZoneName == name);
    } catch (e) {
      return null;
    }
  }

  // Default timezones list (can be used for seeding)
  static const List<Map<String, dynamic>> defaultTimeZones = [
    {
      'location': 'Paris, France',
      'displayName': 'Paris',
      'timeZoneName': 'Europe/Paris',
      'country': 'FR',
      'utcOffset': 60,
    },
    {
      'location': 'Shanghai, China',
      'displayName': 'Shanghai',
      'timeZoneName': 'Asia/Shanghai',
      'country': 'CN',
      'utcOffset': 480,
    },
    {
      'location': 'New York, USA',
      'displayName': 'New York',
      'timeZoneName': 'America/New_York',
      'country': 'US',
      'utcOffset': -300,
    },
    {
      'location': 'London, UK',
      'displayName': 'London',
      'timeZoneName': 'Europe/London',
      'country': 'GB',
      'utcOffset': 0,
    },
    {
      'location': 'Tokyo, Japan',
      'displayName': 'Tokyo',
      'timeZoneName': 'Asia/Tokyo',
      'country': 'JP',
      'utcOffset': 540,
    },
    {
      'location': 'Sydney, Australia',
      'displayName': 'Sydney',
      'timeZoneName': 'Australia/Sydney',
      'country': 'AU',
      'utcOffset': 600,
    },
  ];
}
