import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo.dart';

class DatabaseProvider {
  static const String tableToDos = "todos";
  static const String id = "id";
  static const String text = "text";
  static const String done = "done";
  static const String time = "time";
  static const String isImportant = "isImportant";
  static const String image = "image";

  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();

  Database? _database;

  Future<Database> get database async {
    _database ??= await createDatabase();

    return _database!;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'celer_tad.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        await database.execute(
          "CREATE TABLE $tableToDos ("
          "$id INTEGER PRIMARY KEY,"
          "$text TEXT,"
          "$done INTEGER,"
          "$time TEXT,"
          "$isImportant INTEGER,"
          "$image TEXT"
          ")",
        );
      },
    );
  }

  Future<int> addTodo(Todo todo) async {
    Database db = await database;
    int result = await db.insert(tableToDos, todo.toJson());

    return result;
  }

  Future<List<Todo>> getTodos() async {
    Database db = await database;

    var result = await db.query(tableToDos);

    List<Todo> todos = <Todo>[];

    for (int i = 0; i < result.length; i++) {
      todos.add(Todo.fromJson(result[i]));
    }

    return todos;
  }

  Future<void> deleteAll() async {
    String dbPath = await getDatabasesPath();
    await deleteDatabase(dbPath);
  }
}
