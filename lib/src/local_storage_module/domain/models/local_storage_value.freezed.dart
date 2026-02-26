// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_storage_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocalStorageValue {

 StorageKey get key;@BytesJsonConverter() Bytes get bytes; Map<String, Object?> get metadata;
/// Create a copy of LocalStorageValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalStorageValueCopyWith<LocalStorageValue> get copyWith => _$LocalStorageValueCopyWithImpl<LocalStorageValue>(this as LocalStorageValue, _$identity);

  /// Serializes this LocalStorageValue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalStorageValue&&(identical(other.key, key) || other.key == key)&&const DeepCollectionEquality().equals(other.bytes, bytes)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,const DeepCollectionEquality().hash(bytes),const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'LocalStorageValue(key: $key, bytes: $bytes, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $LocalStorageValueCopyWith<$Res>  {
  factory $LocalStorageValueCopyWith(LocalStorageValue value, $Res Function(LocalStorageValue) _then) = _$LocalStorageValueCopyWithImpl;
@useResult
$Res call({
 StorageKey key,@BytesJsonConverter() Bytes bytes, Map<String, Object?> metadata
});


$StorageKeyCopyWith<$Res> get key;

}
/// @nodoc
class _$LocalStorageValueCopyWithImpl<$Res>
    implements $LocalStorageValueCopyWith<$Res> {
  _$LocalStorageValueCopyWithImpl(this._self, this._then);

  final LocalStorageValue _self;
  final $Res Function(LocalStorageValue) _then;

/// Create a copy of LocalStorageValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? bytes = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as StorageKey,bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Bytes,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}
/// Create a copy of LocalStorageValue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StorageKeyCopyWith<$Res> get key {
  
  return $StorageKeyCopyWith<$Res>(_self.key, (value) {
    return _then(_self.copyWith(key: value));
  });
}
}


/// Adds pattern-matching-related methods to [LocalStorageValue].
extension LocalStorageValuePatterns on LocalStorageValue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocalStorageValue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocalStorageValue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocalStorageValue value)  $default,){
final _that = this;
switch (_that) {
case _LocalStorageValue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocalStorageValue value)?  $default,){
final _that = this;
switch (_that) {
case _LocalStorageValue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StorageKey key, @BytesJsonConverter()  Bytes bytes,  Map<String, Object?> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocalStorageValue() when $default != null:
return $default(_that.key,_that.bytes,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StorageKey key, @BytesJsonConverter()  Bytes bytes,  Map<String, Object?> metadata)  $default,) {final _that = this;
switch (_that) {
case _LocalStorageValue():
return $default(_that.key,_that.bytes,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StorageKey key, @BytesJsonConverter()  Bytes bytes,  Map<String, Object?> metadata)?  $default,) {final _that = this;
switch (_that) {
case _LocalStorageValue() when $default != null:
return $default(_that.key,_that.bytes,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LocalStorageValue extends LocalStorageValue {
  const _LocalStorageValue({required this.key, @BytesJsonConverter() required this.bytes, final  Map<String, Object?> metadata = const <String, Object?>{}}): _metadata = metadata,super._();
  factory _LocalStorageValue.fromJson(Map<String, dynamic> json) => _$LocalStorageValueFromJson(json);

@override final  StorageKey key;
@override@BytesJsonConverter() final  Bytes bytes;
 final  Map<String, Object?> _metadata;
@override@JsonKey() Map<String, Object?> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of LocalStorageValue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalStorageValueCopyWith<_LocalStorageValue> get copyWith => __$LocalStorageValueCopyWithImpl<_LocalStorageValue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocalStorageValueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalStorageValue&&(identical(other.key, key) || other.key == key)&&const DeepCollectionEquality().equals(other.bytes, bytes)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,const DeepCollectionEquality().hash(bytes),const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'LocalStorageValue(key: $key, bytes: $bytes, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$LocalStorageValueCopyWith<$Res> implements $LocalStorageValueCopyWith<$Res> {
  factory _$LocalStorageValueCopyWith(_LocalStorageValue value, $Res Function(_LocalStorageValue) _then) = __$LocalStorageValueCopyWithImpl;
@override @useResult
$Res call({
 StorageKey key,@BytesJsonConverter() Bytes bytes, Map<String, Object?> metadata
});


@override $StorageKeyCopyWith<$Res> get key;

}
/// @nodoc
class __$LocalStorageValueCopyWithImpl<$Res>
    implements _$LocalStorageValueCopyWith<$Res> {
  __$LocalStorageValueCopyWithImpl(this._self, this._then);

  final _LocalStorageValue _self;
  final $Res Function(_LocalStorageValue) _then;

/// Create a copy of LocalStorageValue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? bytes = null,Object? metadata = null,}) {
  return _then(_LocalStorageValue(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as StorageKey,bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Bytes,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}

/// Create a copy of LocalStorageValue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StorageKeyCopyWith<$Res> get key {
  
  return $StorageKeyCopyWith<$Res>(_self.key, (value) {
    return _then(_self.copyWith(key: value));
  });
}
}

// dart format on
