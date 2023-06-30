import 'package:flutter/foundation.dart';

@immutable
abstract class AppException implements Exception {
  const AppException(this.message, [this.stackTrace]);

  final String message;
  final StackTrace? stackTrace;

  String _returnStackTrace() => stackTrace != null ? '\n${stackTrace.toString()}' : '';

  @override
  String toString() => '$message${_returnStackTrace()}';
}
