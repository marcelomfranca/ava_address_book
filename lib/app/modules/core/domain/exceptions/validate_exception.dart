class ValidateException implements Exception {
  ValidateException(this.code, this.message, [StackTrace? stackTrace]) {
    this.stackTrace = stackTrace ?? StackTrace.current;
  }

  final String code;
  final String message;
  late StackTrace stackTrace;
}
