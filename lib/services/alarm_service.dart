import 'package:uuid/uuid.dart';
import '../models/alarm.dart';
import 'database_service.dart';

class AlarmService {
  final DatabaseService _db = DatabaseService();

  // Create new alarm
  Future<Alarm> createAlarm({
    required int hour,
    required int minute,
    String label = 'Wake up',
    List<int> repeatDays = const [],
    String sound = 'Constellation',
    int snoozeDuration = 5,
    int autoSilentTime = 15,
  }) async {
    const uuid = Uuid();
    final alarm = Alarm(
      id: uuid.v4(),
      hour: hour,
      minute: minute,
      label: label,
      repeatDays: repeatDays,
      sound: sound,
      snoozeDuration: snoozeDuration,
      autoSilentTime: autoSilentTime,
    );

    await _db.insertAlarm(alarm);
    return alarm;
  }

  // Get all alarms
  Future<List<Alarm>> getAllAlarms() async {
    return await _db.getAllAlarms();
  }

  // Get alarm by ID
  Future<Alarm?> getAlarmById(String id) async {
    return await _db.getAlarmById(id);
  }

  // Update alarm
  Future<void> updateAlarm(Alarm alarm) async {
    await _db.updateAlarm(alarm);
  }

  // Delete alarm
  Future<void> deleteAlarm(String id) async {
    await _db.deleteAlarm(id);
  }

  // Toggle alarm enabled/disabled
  Future<void> toggleAlarm(String id, bool enabled) async {
    final alarm = await _db.getAlarmById(id);
    if (alarm != null) {
      await _db.updateAlarm(alarm.copyWith(enabled: enabled));
    }
  }

  // Get next alarm (earliest upcoming)
  Future<Alarm?> getNextAlarm() async {
    final alarms = await _db.getAllAlarms();
    final enabledAlarms = alarms.where((a) => a.enabled).toList();
    
    if (enabledAlarms.isEmpty) return null;

    var nextAlarm = enabledAlarms.first;
    var nextTime = nextAlarm.getNextTriggerTime();

    for (var alarm in enabledAlarms) {
      final triggerTime = alarm.getNextTriggerTime();
      if (triggerTime.isBefore(nextTime)) {
        nextAlarm = alarm;
        nextTime = triggerTime;
      }
    }

    return nextAlarm;
  }

  // Get time until next alarm
  Future<Duration?> getTimeUntilNextAlarm() async {
    final alarm = await getNextAlarm();
    if (alarm == null) return null;

    final nextTime = alarm.getNextTriggerTime();
    return nextTime.difference(DateTime.now());
  }

  // Get enabled alarms
  Future<List<Alarm>> getEnabledAlarms() async {
    final alarms = await _db.getAllAlarms();
    return alarms.where((a) => a.enabled).toList();
  }

  // Get repeat days as string (Mo Tu We Th Fr Sa Su)
  static String formatRepeatDays(List<int> days) {
    const dayNames = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    if (days.isEmpty) return 'Once';
    if (days.length == 7) return 'Every day';
    
    return days.map((d) => dayNames[d]).join(' ');
  }

  // Get hours and minutes from Alarm as formatted string
  static String formatTime(int hour, int minute, {bool use24Hour = false}) {
    if (use24Hour) {
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    } else {
      final displayHour = hour % 12 == 0 ? 12 : hour % 12;
      final period = hour >= 12 ? 'PM' : 'AM';
      return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
    }
  }
}
