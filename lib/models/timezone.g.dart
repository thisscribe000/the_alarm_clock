// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timezone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeZoneItem _$TimeZoneItemFromJson(Map<String, dynamic> json) => TimeZoneItem(
      id: json['id'] as String,
      location: json['location'] as String,
      timeZoneName: json['timeZoneName'] as String,
      displayName: json['displayName'] as String,
      country: json['country'] as String?,
      utcOffset: (json['utcOffset'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$TimeZoneItemToJson(TimeZoneItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location': instance.location,
      'timeZoneName': instance.timeZoneName,
      'displayName': instance.displayName,
      'country': instance.country,
      'utcOffset': instance.utcOffset,
      'createdAt': instance.createdAt.toIso8601String(),
    };
