// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NetworkRequest {

 String get url; HttpMethod get method; Map<String, String> get headers; dynamic get body; Map<String, String>? get queryParameters;
/// Create a copy of NetworkRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkRequestCopyWith<NetworkRequest> get copyWith => _$NetworkRequestCopyWithImpl<NetworkRequest>(this as NetworkRequest, _$identity);

  /// Serializes this NetworkRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkRequest&&(identical(other.url, url) || other.url == url)&&(identical(other.method, method) || other.method == method)&&const DeepCollectionEquality().equals(other.headers, headers)&&const DeepCollectionEquality().equals(other.body, body)&&const DeepCollectionEquality().equals(other.queryParameters, queryParameters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,method,const DeepCollectionEquality().hash(headers),const DeepCollectionEquality().hash(body),const DeepCollectionEquality().hash(queryParameters));

@override
String toString() {
  return 'NetworkRequest(url: $url, method: $method, headers: $headers, body: $body, queryParameters: $queryParameters)';
}


}

/// @nodoc
abstract mixin class $NetworkRequestCopyWith<$Res>  {
  factory $NetworkRequestCopyWith(NetworkRequest value, $Res Function(NetworkRequest) _then) = _$NetworkRequestCopyWithImpl;
@useResult
$Res call({
 String url, HttpMethod method, Map<String, String> headers, dynamic body, Map<String, String>? queryParameters
});




}
/// @nodoc
class _$NetworkRequestCopyWithImpl<$Res>
    implements $NetworkRequestCopyWith<$Res> {
  _$NetworkRequestCopyWithImpl(this._self, this._then);

  final NetworkRequest _self;
  final $Res Function(NetworkRequest) _then;

/// Create a copy of NetworkRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? method = null,Object? headers = null,Object? body = freezed,Object? queryParameters = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as HttpMethod,headers: null == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as dynamic,queryParameters: freezed == queryParameters ? _self.queryParameters : queryParameters // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [NetworkRequest].
extension NetworkRequestPatterns on NetworkRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NetworkRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NetworkRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NetworkRequest value)  $default,){
final _that = this;
switch (_that) {
case _NetworkRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NetworkRequest value)?  $default,){
final _that = this;
switch (_that) {
case _NetworkRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  HttpMethod method,  Map<String, String> headers,  dynamic body,  Map<String, String>? queryParameters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NetworkRequest() when $default != null:
return $default(_that.url,_that.method,_that.headers,_that.body,_that.queryParameters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  HttpMethod method,  Map<String, String> headers,  dynamic body,  Map<String, String>? queryParameters)  $default,) {final _that = this;
switch (_that) {
case _NetworkRequest():
return $default(_that.url,_that.method,_that.headers,_that.body,_that.queryParameters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  HttpMethod method,  Map<String, String> headers,  dynamic body,  Map<String, String>? queryParameters)?  $default,) {final _that = this;
switch (_that) {
case _NetworkRequest() when $default != null:
return $default(_that.url,_that.method,_that.headers,_that.body,_that.queryParameters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NetworkRequest implements NetworkRequest {
  const _NetworkRequest({required this.url, required this.method, final  Map<String, String> headers = const {}, this.body = null, final  Map<String, String>? queryParameters = const {}}): _headers = headers,_queryParameters = queryParameters;
  factory _NetworkRequest.fromJson(Map<String, dynamic> json) => _$NetworkRequestFromJson(json);

@override final  String url;
@override final  HttpMethod method;
 final  Map<String, String> _headers;
@override@JsonKey() Map<String, String> get headers {
  if (_headers is EqualUnmodifiableMapView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_headers);
}

@override@JsonKey() final  dynamic body;
 final  Map<String, String>? _queryParameters;
@override@JsonKey() Map<String, String>? get queryParameters {
  final value = _queryParameters;
  if (value == null) return null;
  if (_queryParameters is EqualUnmodifiableMapView) return _queryParameters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of NetworkRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetworkRequestCopyWith<_NetworkRequest> get copyWith => __$NetworkRequestCopyWithImpl<_NetworkRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NetworkRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkRequest&&(identical(other.url, url) || other.url == url)&&(identical(other.method, method) || other.method == method)&&const DeepCollectionEquality().equals(other._headers, _headers)&&const DeepCollectionEquality().equals(other.body, body)&&const DeepCollectionEquality().equals(other._queryParameters, _queryParameters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,method,const DeepCollectionEquality().hash(_headers),const DeepCollectionEquality().hash(body),const DeepCollectionEquality().hash(_queryParameters));

@override
String toString() {
  return 'NetworkRequest(url: $url, method: $method, headers: $headers, body: $body, queryParameters: $queryParameters)';
}


}

/// @nodoc
abstract mixin class _$NetworkRequestCopyWith<$Res> implements $NetworkRequestCopyWith<$Res> {
  factory _$NetworkRequestCopyWith(_NetworkRequest value, $Res Function(_NetworkRequest) _then) = __$NetworkRequestCopyWithImpl;
@override @useResult
$Res call({
 String url, HttpMethod method, Map<String, String> headers, dynamic body, Map<String, String>? queryParameters
});




}
/// @nodoc
class __$NetworkRequestCopyWithImpl<$Res>
    implements _$NetworkRequestCopyWith<$Res> {
  __$NetworkRequestCopyWithImpl(this._self, this._then);

  final _NetworkRequest _self;
  final $Res Function(_NetworkRequest) _then;

/// Create a copy of NetworkRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? method = null,Object? headers = null,Object? body = freezed,Object? queryParameters = freezed,}) {
  return _then(_NetworkRequest(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as HttpMethod,headers: null == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as dynamic,queryParameters: freezed == queryParameters ? _self._queryParameters : queryParameters // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}


}

// dart format on
