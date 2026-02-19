// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NetworkRequest _$NetworkRequestFromJson(Map<String, dynamic> json) =>
    _NetworkRequest(
      url: json['url'] as String,
      method: $enumDecode(_$HttpMethodEnumMap, json['method']),
      headers:
          (json['headers'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      body: json['body'] ?? null,
      queryParameters:
          (json['queryParameters'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
    );

Map<String, dynamic> _$NetworkRequestToJson(_NetworkRequest instance) =>
    <String, dynamic>{
      'url': instance.url,
      'method': _$HttpMethodEnumMap[instance.method]!,
      'headers': instance.headers,
      'body': instance.body,
      'queryParameters': instance.queryParameters,
    };

const _$HttpMethodEnumMap = {
  HttpMethod.get: 'get',
  HttpMethod.post: 'post',
  HttpMethod.put: 'put',
  HttpMethod.delete: 'delete',
  HttpMethod.patch: 'patch',
  HttpMethod.head: 'head',
  HttpMethod.options: 'options',
};
