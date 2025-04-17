import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yourlist1/model/todo.dart';

class TodoDatabaseHelper {
  static final TodoDatabaseHelper instance = TodoDatabaseHelper._init();
  static Database? _database;
  TodoDatabaseHelper._init();

  Future<Database?> get data async {
    if (_database != null) return _database;
    _database = await _init('app_database.db');
    return _database;
  }

  Future<Database> _init(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT NOT NULL,
        time TEXT NOT NULL
      )
    ''');
    // await _insertSampleData(db);
  }

  // ✅ Insert Todo
  Future<int> insertTodo(Todo todo) async {
    final db = await data;
    return await db!.insert('todo', todo.toMap());
  }

  // ✅ Get all Todos
  Future<List<Todo>> getAllTodos() async {
    final db = await data;
    final result = await db!.query('todo');
    return result.map((json) => Todo.fromMap(json)).toList();
  }

  // ✅ Update Todo
  Future<int> updateTodo(Todo todo) async {
    final db = await data;
    return await db!.update(
      'todo',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  // ✅ Delete Todo
  Future<int> deleteTodo(int id) async {
    final db = await data;
    return await db!.delete('todo', where: 'id = ?', whereArgs: [id]);
  }

  // ✅ Close Database
  Future close() async {
    final db = await data;
    db?.close();
  }

  Future<Todo?> getTodo(int id) async {
    final db = await data;
    final result = await db!.query('todo', where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return Todo.fromMap(result.first);
    } else {
      return null;
    }
  }
}
