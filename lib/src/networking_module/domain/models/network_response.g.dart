// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NetworkResponse _$NetworkResponseFromJson(Map<String, dynamic> json) =>
    _NetworkResponse(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      statusMessage: json['statusMessage'] as String?,
      body: json['body'],
      request: NetworkRequest.fromJson(json['request'] as Map<String, dynamic>),
      headers:
          (json['headers'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              k,
              (e as List<dynamic>).map((e) => e as String).toList(),
            ),
          ) ??
          const {},
    );

Map<String, dynamic> _$NetworkResponseToJson(_NetworkResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'statusMessage': instance.statusMessage,
      'body': instance.body,
      'request': instance.request,
      'headers': instance.headers,
    };
