// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alarm _$AlarmFromJson(Map<String, dynamic> json) => Alarm(
      id: json['id'] as String,
      hour: (json['hour'] as num).toInt(),
      minute: (json['minute'] as num).toInt(),
      label: json['label'] as String? ?? 'Wake up',
      enabled: json['enabled'] as bool? ?? true,
      repeatDays: (json['repeatDays'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      sound: json['sound'] as String? ?? 'Constellation',
      snoozeDuration: (json['snoozeDuration'] as num?)?.toInt() ?? 5,
      autoSilentTime: (json['autoSilentTime'] as num?)?.toInt() ?? 15,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastTriggeredAt: json['lastTriggeredAt'] == null
          ? null
          : DateTime.parse(json['lastTriggeredAt'] as String),
    );

Map<String, dynamic> _$AlarmToJson(Alarm instance) => <String, dynamic>{
      'id': instance.id,
      'hour': instance.hour,
      'minute': instance.minute,
      'label': instance.label,
      'enabled': instance.enabled,
      'repeatDays': instance.repeatDays,
      'sound': instance.sound,
      'snoozeDuration': instance.snoozeDuration,
      'autoSilentTime': instance.autoSilentTime,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastTriggeredAt': instance.lastTriggeredAt?.toIso8601String(),
    };
