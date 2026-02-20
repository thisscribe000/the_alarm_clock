import 'package:json_annotation/json_annotation.dart';

part 'timezone.g.dart';

@JsonSerializable()
class TimeZoneItem {
  final String id;
  final String location; // e.g., "Paris, France"
  final String timeZoneName; // e.g., "Europe/Paris"
  final String displayName; // e.g., "Paris"
  final String? country; // ISO country code
  final int utcOffset; // in minutes
  final DateTime createdAt;

  TimeZoneItem({
    required this.id,
    required this.location,
    required this.timeZoneName,
    required this.displayName,
    this.country,
    this.utcOffset = 0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Get current time in this timezone
  DateTime getCurrentTime() {
    final utc = DateTime.now().toUtc();
    return utc.add(Duration(minutes: utcOffset));
  }

  // Format current time as HH:MM
  String getFormattedTime({bool use24Hour = false}) {
    final time = getCurrentTime();
    if (use24Hour) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else {
      final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
      final period = time.hour >= 12 ? 'PM' : 'AM';
      return '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period';
    }
  }

  // Get formatted date
  String getFormattedDate() {
    final time = getCurrentTime();
    final days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    final months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
    return '${days[time.weekday - 1]} ${months[time.month - 1]} ${time.day}';
  }

  TimeZoneItem copyWith({
    String? id,
    String? location,
    String? timeZoneName,
    String? displayName,
    String? country,
    int? utcOffset,
    DateTime? createdAt,
  }) {
    return TimeZoneItem(
      id: id ?? this.id,
      location: location ?? this.location,
      timeZoneName: timeZoneName ?? this.timeZoneName,
      displayName: displayName ?? this.displayName,
      country: country ?? this.country,
      utcOffset: utcOffset ?? this.utcOffset,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory TimeZoneItem.fromJson(Map<String, dynamic> json) => _$TimeZoneItemFromJson(json);
  Map<String, dynamic> toJson() => _$TimeZoneItemToJson(this);
}
