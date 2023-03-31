import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:gymbro/model/section.dart';

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
CREATE TABLE $sectionTable (
  ${SectionFields.id} $idType,
  ${SectionFields.title} $textType
)
''');
  }

  Future<Section> create(Section exercise) async {
    final db = await instance.database;
    final id = await db.insert(sectionTable, exercise.toJson());

    return exercise.copy(id: id);
  }

  Future<Section> readExercise(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      sectionTable,
      columns: SectionFields.values,
      where: '${SectionFields.id} = ?',
      whereArgs: [id]
    );

    if(maps.isNotEmpty){
      return Section.fromJson(maps.first);
    }else {
      throw Exception('Id ${id} not found');
    }
  }

  Future<List<Section>> readAllExercises() async {
    final db = await instance.database;
    final orderBy = '${SectionFields.id} ASC'; 
    final result = await db.query(sectionTable, orderBy:orderBy);

    return result.map((json) => Section.fromJson(json)).toList();
  }

  Future<int> update(Section exercise) async {
    final db = await instance.database;

    return db.update(
      sectionTable,
      exercise.toJson(),
      where: '${SectionFields.id} = ?',
      whereArgs: [exercise.id]
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      sectionTable,
      where: '${SectionFields.id} = ?',
      whereArgs: [id]
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
