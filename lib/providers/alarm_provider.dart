import 'package:flutter/material.dart';
import '../models/alarm.dart';
import '../services/alarm_service.dart';

class AlarmProvider extends ChangeNotifier {
  final AlarmService _alarmService = AlarmService();
  
  List<Alarm> _alarms = [];
  bool _isLoading = true;
  String? _error;

  List<Alarm> get alarms => _alarms;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Alarm? get nextAlarm {
    if (_alarms.isEmpty) return null;
    final enabledAlarms = _alarms.where((a) => a.enabled).toList();
    if (enabledAlarms.isEmpty) return null;

    var next = enabledAlarms.first;
    var nextTime = next.getNextTriggerTime();

    for (var alarm in enabledAlarms) {
      final triggerTime = alarm.getNextTriggerTime();
      if (triggerTime.isBefore(nextTime)) {
        next = alarm;
        nextTime = triggerTime;
      }
    }
    return next;
  }

  Duration? get timeUntilNextAlarm {
    final alarm = nextAlarm;
    if (alarm == null) return null;
    return alarm.getNextTriggerTime().difference(DateTime.now());
  }

  AlarmProvider() {
    loadAlarms();
  }

  Future<void> loadAlarms() async {
    try {
      _isLoading = true;
      _error = null;
      _alarms = await _alarmService.getAllAlarms();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addAlarm({
    required int hour,
    required int minute,
    String label = 'Wake up',
    List<int> repeatDays = const [],
    String sound = 'Constellation',
    int snoozeDuration = 5,
    int autoSilentTime = 15,
  }) async {
    try {
      await _alarmService.createAlarm(
        hour: hour,
        minute: minute,
        label: label,
        repeatDays: repeatDays,
        sound: sound,
        snoozeDuration: snoozeDuration,
        autoSilentTime: autoSilentTime,
      );
      await loadAlarms();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateAlarm(Alarm alarm) async {
    try {
      await _alarmService.updateAlarm(alarm);
      await loadAlarms();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteAlarm(String id) async {
    try {
      await _alarmService.deleteAlarm(id);
      await loadAlarms();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> toggleAlarm(String id, bool enabled) async {
    try {
      await _alarmService.toggleAlarm(id, enabled);
      await loadAlarms();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  List<Alarm> get enabledAlarms => _alarms.where((a) => a.enabled).toList();
}
