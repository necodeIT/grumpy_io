// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NetworkResponse {

/// The HTTP status code of the response.
 int? get statusCode;/// The HTTP status message of the response.
 String? get statusMessage;/// The body of the response. Can be of any type depending on the response content.
 dynamic get body;/// The original request that resulted in this response.
 NetworkRequest get request;/// The headers of the response. Defaults to an empty map if not provided.
 Map<String, List<String>> get headers;
/// Create a copy of NetworkResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkResponseCopyWith<NetworkResponse> get copyWith => _$NetworkResponseCopyWithImpl<NetworkResponse>(this as NetworkResponse, _$identity);

  /// Serializes this NetworkResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkResponse&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage)&&const DeepCollectionEquality().equals(other.body, body)&&(identical(other.request, request) || other.request == request)&&const DeepCollectionEquality().equals(other.headers, headers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusCode,statusMessage,const DeepCollectionEquality().hash(body),request,const DeepCollectionEquality().hash(headers));

@override
String toString() {
  return 'NetworkResponse(statusCode: $statusCode, statusMessage: $statusMessage, body: $body, request: $request, headers: $headers)';
}


}

/// @nodoc
abstract mixin class $NetworkResponseCopyWith<$Res>  {
  factory $NetworkResponseCopyWith(NetworkResponse value, $Res Function(NetworkResponse) _then) = _$NetworkResponseCopyWithImpl;
@useResult
$Res call({
 int? statusCode, String? statusMessage, dynamic body, NetworkRequest request, Map<String, List<String>> headers
});


$NetworkRequestCopyWith<$Res> get request;

}
/// @nodoc
class _$NetworkResponseCopyWithImpl<$Res>
    implements $NetworkResponseCopyWith<$Res> {
  _$NetworkResponseCopyWithImpl(this._self, this._then);

  final NetworkResponse _self;
  final $Res Function(NetworkResponse) _then;

/// Create a copy of NetworkResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statusCode = freezed,Object? statusMessage = freezed,Object? body = freezed,Object? request = null,Object? headers = null,}) {
  return _then(_self.copyWith(
statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,statusMessage: freezed == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as dynamic,request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as NetworkRequest,headers: null == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,
  ));
}
/// Create a copy of NetworkResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkRequestCopyWith<$Res> get request {
  
  return $NetworkRequestCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}


/// Adds pattern-matching-related methods to [NetworkResponse].
extension NetworkResponsePatterns on NetworkResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NetworkResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NetworkResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NetworkResponse value)  $default,){
final _that = this;
switch (_that) {
case _NetworkResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NetworkResponse value)?  $default,){
final _that = this;
switch (_that) {
case _NetworkResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? statusCode,  String? statusMessage,  dynamic body,  NetworkRequest request,  Map<String, List<String>> headers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NetworkResponse() when $default != null:
return $default(_that.statusCode,_that.statusMessage,_that.body,_that.request,_that.headers);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? statusCode,  String? statusMessage,  dynamic body,  NetworkRequest request,  Map<String, List<String>> headers)  $default,) {final _that = this;
switch (_that) {
case _NetworkResponse():
return $default(_that.statusCode,_that.statusMessage,_that.body,_that.request,_that.headers);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? statusCode,  String? statusMessage,  dynamic body,  NetworkRequest request,  Map<String, List<String>> headers)?  $default,) {final _that = this;
switch (_that) {
case _NetworkResponse() when $default != null:
return $default(_that.statusCode,_that.statusMessage,_that.body,_that.request,_that.headers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NetworkResponse implements NetworkResponse {
  const _NetworkResponse({this.statusCode, this.statusMessage, required this.body, required this.request, final  Map<String, List<String>> headers = const {}}): _headers = headers;
  factory _NetworkResponse.fromJson(Map<String, dynamic> json) => _$NetworkResponseFromJson(json);

/// The HTTP status code of the response.
@override final  int? statusCode;
/// The HTTP status message of the response.
@override final  String? statusMessage;
/// The body of the response. Can be of any type depending on the response content.
@override final  dynamic body;
/// The original request that resulted in this response.
@override final  NetworkRequest request;
/// The headers of the response. Defaults to an empty map if not provided.
 final  Map<String, List<String>> _headers;
/// The headers of the response. Defaults to an empty map if not provided.
@override@JsonKey() Map<String, List<String>> get headers {
  if (_headers is EqualUnmodifiableMapView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_headers);
}


/// Create a copy of NetworkResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetworkResponseCopyWith<_NetworkResponse> get copyWith => __$NetworkResponseCopyWithImpl<_NetworkResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NetworkResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkResponse&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage)&&const DeepCollectionEquality().equals(other.body, body)&&(identical(other.request, request) || other.request == request)&&const DeepCollectionEquality().equals(other._headers, _headers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusCode,statusMessage,const DeepCollectionEquality().hash(body),request,const DeepCollectionEquality().hash(_headers));

@override
String toString() {
  return 'NetworkResponse(statusCode: $statusCode, statusMessage: $statusMessage, body: $body, request: $request, headers: $headers)';
}


}

/// @nodoc
abstract mixin class _$NetworkResponseCopyWith<$Res> implements $NetworkResponseCopyWith<$Res> {
  factory _$NetworkResponseCopyWith(_NetworkResponse value, $Res Function(_NetworkResponse) _then) = __$NetworkResponseCopyWithImpl;
@override @useResult
$Res call({
 int? statusCode, String? statusMessage, dynamic body, NetworkRequest request, Map<String, List<String>> headers
});


@override $NetworkRequestCopyWith<$Res> get request;

}
/// @nodoc
class __$NetworkResponseCopyWithImpl<$Res>
    implements _$NetworkResponseCopyWith<$Res> {
  __$NetworkResponseCopyWithImpl(this._self, this._then);

  final _NetworkResponse _self;
  final $Res Function(_NetworkResponse) _then;

/// Create a copy of NetworkResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statusCode = freezed,Object? statusMessage = freezed,Object? body = freezed,Object? request = null,Object? headers = null,}) {
  return _then(_NetworkResponse(
statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,statusMessage: freezed == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as dynamic,request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as NetworkRequest,headers: null == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,
  ));
}

/// Create a copy of NetworkResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkRequestCopyWith<$Res> get request {
  
  return $NetworkRequestCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}

// dart format on
