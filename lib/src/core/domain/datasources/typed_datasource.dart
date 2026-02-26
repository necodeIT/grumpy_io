// This is a base type for typed datasource abstractions, and is not to be instantiated directly.
// ignore_for_file: domain_factory_from_di_missing_factory

import 'package:grumpy/grumpy.dart';

/// Base type for module-local typed datasource abstractions.
abstract class TypedDatasource extends Datasource {
  /// Creates a typed datasource.
  const TypedDatasource.internal() : super();

  @override
  bool get singelton => true;
  @override
  String get group => '${super.group}.TypedDatasource';
}
