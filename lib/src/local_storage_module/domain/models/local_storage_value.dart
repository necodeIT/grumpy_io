import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grumpy/grumpy.dart';
import 'package:grumpy_io/grumpy_io.dart';

part 'local_storage_value.freezed.dart';
part 'local_storage_value.g.dart';

/// Stored local value envelope.
@freezed
abstract class LocalStorageValue extends Model with _$LocalStorageValue {
  const LocalStorageValue._();

  /// Creates a local storage value.
  const factory LocalStorageValue({
    required StorageKey key,
    @BytesJsonConverter() required Bytes bytes,
    @Default(<String, Object?>{}) Map<String, Object?> metadata,
  }) = _LocalStorageValue;

  /// Creates a [LocalStorageValue] from JSON.
  factory LocalStorageValue.fromJson(JsonMap json) =>
      _$LocalStorageValueFromJson(json);
}
