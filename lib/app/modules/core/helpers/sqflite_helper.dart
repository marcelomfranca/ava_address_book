import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQFLiteConfig {
  SQFLiteConfig._();

  static Future<Database> initialize(
    Future<void> Function(Database, int)? onCreated,
    Future<void> Function(Database, int, int)? onUpgrade,
    String databaseName,
  ) async {
    final databasesPath = await getDatabasesPath();
    final fullPath = join(databasesPath, databaseName);

    return await openDatabase(fullPath, version: 1, onCreate: onCreated, onUpgrade: onUpgrade);
  }
}
