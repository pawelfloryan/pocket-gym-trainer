import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:gymbro/model/tables.dart';

class LibreGymDatabase {
  static final LibreGymDatabase instance = LibreGymDatabase._init();

  static Database? _database;

  LibreGymDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('Libregym.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    final textType = "TEXT NOT NULL";

    await db.execute('''
CREATE TABLE $exerciseTable (
  ${ExerciseFields.id} $idType,
  ${ExerciseFields.title} $textType
)
''');
  }

  Future<Exercise> create(Exercise exercise) async {
    final db = await instance.database;
    final id = await db.insert(exerciseTable, exercise.toJson());

    return exercise.copy(id: id);
  }

  Future<Exercise> readExercise(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      exerciseTable,
      columns: ExerciseFields.values,
      where: '${ExerciseFields.id} = ?',
      whereArgs: [id]
    );

    if(maps.isNotEmpty){
      return Exercise.fromJson(maps.first);
    }else {
      throw Exception('Id ${id} not found');
    }
  }

  Future<List<Exercise>> readAllExercises() async {
    final db = await instance.database;
    final orderBy = '${ExerciseFields.id} ASC'; 
    final result = await db.query(exerciseTable, orderBy:orderBy);

    return result.map((json) => Exercise.fromJson(json)).toList();
  }

  Future<int> update(Exercise exercise) async {
    final db = await instance.database;

    return db.update(
      exerciseTable,
      exercise.toJson(),
      where: '${ExerciseFields.id} = ?',
      whereArgs: [exercise.id]
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      exerciseTable,
      where: '${ExerciseFields.id} = ?',
      whereArgs: [id]
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
