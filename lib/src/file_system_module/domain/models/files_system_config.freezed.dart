// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'files_system_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FilesSystemConfig {

/// The platform the system is running on. This is required to determine the appropriate file system implementation.
 StoragePlatform get platform;
/// Create a copy of FilesSystemConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilesSystemConfigCopyWith<FilesSystemConfig> get copyWith => _$FilesSystemConfigCopyWithImpl<FilesSystemConfig>(this as FilesSystemConfig, _$identity);

  /// Serializes this FilesSystemConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilesSystemConfig&&(identical(other.platform, platform) || other.platform == platform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,platform);

@override
String toString() {
  return 'FilesSystemConfig(platform: $platform)';
}


}

/// @nodoc
abstract mixin class $FilesSystemConfigCopyWith<$Res>  {
  factory $FilesSystemConfigCopyWith(FilesSystemConfig value, $Res Function(FilesSystemConfig) _then) = _$FilesSystemConfigCopyWithImpl;
@useResult
$Res call({
 StoragePlatform platform
});




}
/// @nodoc
class _$FilesSystemConfigCopyWithImpl<$Res>
    implements $FilesSystemConfigCopyWith<$Res> {
  _$FilesSystemConfigCopyWithImpl(this._self, this._then);

  final FilesSystemConfig _self;
  final $Res Function(FilesSystemConfig) _then;

/// Create a copy of FilesSystemConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? platform = null,}) {
  return _then(_self.copyWith(
platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as StoragePlatform,
  ));
}

}


/// Adds pattern-matching-related methods to [FilesSystemConfig].
extension FilesSystemConfigPatterns on FilesSystemConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FilesSystemConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FilesSystemConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FilesSystemConfig value)  $default,){
final _that = this;
switch (_that) {
case _FilesSystemConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FilesSystemConfig value)?  $default,){
final _that = this;
switch (_that) {
case _FilesSystemConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StoragePlatform platform)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FilesSystemConfig() when $default != null:
return $default(_that.platform);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StoragePlatform platform)  $default,) {final _that = this;
switch (_that) {
case _FilesSystemConfig():
return $default(_that.platform);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StoragePlatform platform)?  $default,) {final _that = this;
switch (_that) {
case _FilesSystemConfig() when $default != null:
return $default(_that.platform);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FilesSystemConfig implements FilesSystemConfig {
  const _FilesSystemConfig({required this.platform});
  factory _FilesSystemConfig.fromJson(Map<String, dynamic> json) => _$FilesSystemConfigFromJson(json);

/// The platform the system is running on. This is required to determine the appropriate file system implementation.
@override final  StoragePlatform platform;

/// Create a copy of FilesSystemConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilesSystemConfigCopyWith<_FilesSystemConfig> get copyWith => __$FilesSystemConfigCopyWithImpl<_FilesSystemConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FilesSystemConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilesSystemConfig&&(identical(other.platform, platform) || other.platform == platform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,platform);

@override
String toString() {
  return 'FilesSystemConfig(platform: $platform)';
}


}

/// @nodoc
abstract mixin class _$FilesSystemConfigCopyWith<$Res> implements $FilesSystemConfigCopyWith<$Res> {
  factory _$FilesSystemConfigCopyWith(_FilesSystemConfig value, $Res Function(_FilesSystemConfig) _then) = __$FilesSystemConfigCopyWithImpl;
@override @useResult
$Res call({
 StoragePlatform platform
});




}
/// @nodoc
class __$FilesSystemConfigCopyWithImpl<$Res>
    implements _$FilesSystemConfigCopyWith<$Res> {
  __$FilesSystemConfigCopyWithImpl(this._self, this._then);

  final _FilesSystemConfig _self;
  final $Res Function(_FilesSystemConfig) _then;

/// Create a copy of FilesSystemConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? platform = null,}) {
  return _then(_FilesSystemConfig(
platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as StoragePlatform,
  ));
}


}

// dart format on
