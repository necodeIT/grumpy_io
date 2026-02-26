// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocalStorageValue _$LocalStorageValueFromJson(Map<String, dynamic> json) =>
    _LocalStorageValue(
      key: StorageKey.fromJson(json['key'] as Map<String, dynamic>),
      bytes: const BytesJsonConverter().fromJson(json['bytes'] as String),
      metadata:
          json['metadata'] as Map<String, dynamic>? ??
          const <String, Object?>{},
    );

Map<String, dynamic> _$LocalStorageValueToJson(_LocalStorageValue instance) =>
    <String, dynamic>{
      'key': instance.key,
      'bytes': const BytesJsonConverter().toJson(instance.bytes),
      'metadata': instance.metadata,
    };
