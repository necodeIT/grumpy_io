// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'files_system_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FilesSystemConfig _$FilesSystemConfigFromJson(Map<String, dynamic> json) =>
    _FilesSystemConfig(
      platform: $enumDecode(_$StoragePlatformEnumMap, json['platform']),
    );

Map<String, dynamic> _$FilesSystemConfigToJson(_FilesSystemConfig instance) =>
    <String, dynamic>{'platform': _$StoragePlatformEnumMap[instance.platform]!};

const _$StoragePlatformEnumMap = {
  StoragePlatform.android: 'android',
  StoragePlatform.ios: 'ios',
  StoragePlatform.linux: 'linux',
  StoragePlatform.macos: 'macos',
  StoragePlatform.windows: 'windows',
  StoragePlatform.web: 'web',
};
