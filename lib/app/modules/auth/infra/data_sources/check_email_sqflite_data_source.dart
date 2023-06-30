abstract interface class CheckEmailSQFLiteDataSource {
  Future<bool> exists(String email);
}
