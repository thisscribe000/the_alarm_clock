import 'package:json_annotation/json_annotation.dart';

part 'alarm.g.dart';

@JsonSerializable()
class Alarm {
  final String id;
  final int hour;
  final int minute;
  final String label;
  final bool enabled;
  final List<int> repeatDays; // 0=Monday, 1=Tuesday, ..., 6=Sunday
  final String sound;
  final int snoozeDuration; // in minutes
  final int autoSilentTime; // in minutes
  final DateTime createdAt;
  final DateTime? lastTriggeredAt;

  Alarm({
    required this.id,
    required this.hour,
    required this.minute,
    this.label = 'Wake up',
    this.enabled = true,
    this.repeatDays = const [],
    this.sound = 'Constellation',
    this.snoozeDuration = 5,
    this.autoSilentTime = 15,
    DateTime? createdAt,
    this.lastTriggeredAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Check if alarm should trigger today
  bool shouldRepeatToday() {
    if (repeatDays.isEmpty) return true;
    int today = DateTime.now().weekday - 1; // Convert to 0-6 (Monday-Sunday)
    return repeatDays.contains(today);
  }

  // Get next alarm trigger time
  DateTime getNextTriggerTime() {
    final now = DateTime.now();
    var nextTime = DateTime(now.year, now.month, now.day, hour, minute);
    
    if (nextTime.isBefore(now)) {
      nextTime = nextTime.add(const Duration(days: 1));
    }

    // If repeat days specified, find next valid day
    if (repeatDays.isNotEmpty) {
      while (!repeatDays.contains(nextTime.weekday - 1)) {
        nextTime = nextTime.add(const Duration(days: 1));
      }
    }

    return nextTime;
  }

  // Copy with method for updates
  Alarm copyWith({
    String? id,
    int? hour,
    int? minute,
    String? label,
    bool? enabled,
    List<int>? repeatDays,
    String? sound,
    int? snoozeDuration,
    int? autoSilentTime,
    DateTime? createdAt,
    DateTime? lastTriggeredAt,
  }) {
    return Alarm(
      id: id ?? this.id,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      label: label ?? this.label,
      enabled: enabled ?? this.enabled,
      repeatDays: repeatDays ?? this.repeatDays,
      sound: sound ?? this.sound,
      snoozeDuration: snoozeDuration ?? this.snoozeDuration,
      autoSilentTime: autoSilentTime ?? this.autoSilentTime,
      createdAt: createdAt ?? this.createdAt,
      lastTriggeredAt: lastTriggeredAt ?? this.lastTriggeredAt,
    );
  }

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);
  Map<String, dynamic> toJson() => _$AlarmToJson(this);
}
