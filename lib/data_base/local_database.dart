import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/work_out_model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._();
  static Database? _database;

  DatabaseService._();

  factory DatabaseService() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'workouts.db');
    return await openDatabase(
      path,
      onCreate: _createDB,
      version: 1,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE workouts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        value INTEGER,
        date TEXT,
        isDone INTEGER
      )
    ''');
  }

  Future<int> addWorkout(Workout workout) async {
    final db = await database;
    return await db.insert('workouts', workout.toMap());
  }


  Future<List<Workout>> getWorkouts({String? date}) async{
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query('workouts',where: date!=null?'date = ?' : null,
      whereArgs: date != null ? [date] : null,
    );
    return List.generate(maps.length,(i){ return Workout.fromMap(maps[i]);}, );
  }

  Future<void> updateWorkout(Workout workout) async {
    final db = await database;
    await db.update('workouts', workout.toMap(), where: 'id = ?', whereArgs: [workout.id]);
  }

  Future<void> deleteWorkout(int id) async {
    final db = await database;
    await db.delete('workouts', where: 'id = ?', whereArgs: [id]);
  }
}
