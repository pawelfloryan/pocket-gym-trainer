//import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:gymbro/model/section.dart';
//import 'package:gymbro/model/exercise.dart';
//
//class LibreGymDatabase {
//  static final LibreGymDatabase instance = LibreGymDatabase._init();
//
//  static Database? _database;
//
//  LibreGymDatabase._init();
//
//  Future<Database> get database async {
//    if (_database != null) return _database!;
//    _database = await _initDB('Libregym.db');
//
//    return _database!;
//  }
//
//  Future<Database> _initDB(String filePath) async {
//    final dbPath = await getDatabasesPath();
//    final path = join(dbPath, filePath);
//
//    return await openDatabase(path, version: 1, onCreate: _createDB);
//  }
//
//  Future _createDB(Database db, int version) async {
//    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
//    final textType = "TEXT NOT NULL";
//
//    await db.execute('''
//CREATE TABLE $sectionTable (
//  ${SectionFields.id} $idType,
//  ${SectionFields.title} $textType,
//)
//''');
//
//    await db.execute('''
//CREATE TABLE $exerciseTable (
//  ${ExerciseFields.id} $idType,
//  ${ExerciseFields.title} $textType,
//  ${ExerciseFields.image} $textType,
//)
//''');
//  }
//
////Section table methods
//  Future<Section> createSection(Section section) async {
//    final db = await instance.database;
//    final id = await db.insert(sectionTable, section.toJson());
//
//    return section.copy(id: id);
//  }
//
//  Future<Section> readSection(int id) async {
//    final db = await instance.database;
//    final maps = await db.query(sectionTable,
//        columns: SectionFields.values,
//        where: '${SectionFields.id} = ?',
//        whereArgs: [id]);
//
//    if (maps.isNotEmpty) {
//      return Section.fromJson(maps.first);
//    } else {
//      throw Exception('Id ${id} not found');
//    }
//  }
//
//  Future<List<Section>> readAllSections() async {
//    final db = await instance.database;
//    final orderBy = '${SectionFields.id} ASC';
//    final result = await db.query(sectionTable, orderBy: orderBy);
//
//    return result.map((json) => Section.fromJson(json)).toList();
//  }
//
//  Future<int> updateSection(Section section) async {
//    final db = await instance.database;
//
//    return db.update(sectionTable, section.toJson(),
//        where: '${SectionFields.id} = ?', whereArgs: [section.id]);
//  }
//
//  Future<int> deleteSection(int id) async {
//    final db = await instance.database;
//
//    return await db.delete(sectionTable,
//        where: '${SectionFields.id} = ?', whereArgs: [id]);
//  }
//
////Exercise table methods
//  Future<Exercise> createExercise(Exercise exercise) async {
//    final db = await instance.database;
//    final id = await db.insert(exerciseTable, exercise.toJson());
//
//    return exercise.copy(id: id);
//  }
//
//  Future<List<Exercise>> readAllExercises() async {
//    final db = await instance.database;
//    final orderBy = '${ExerciseFields.id} ASC';
//    final result = await db.query(sectionTable, orderBy: orderBy);
//
//    return result.map((json) => Exercise.fromJson(json)).toList();
//  }
//
//  Future<int> updateExercise(Exercise exercise) async {
//    final db = await instance.database;
//
//    return db.update(exerciseTable, exercise.toJson(),
//        where: '${ExerciseFields.id} = ?', whereArgs: [exercise.id]);
//  }
//
//  Future<int> deleteExercise(int id) async {
//    final db = await instance.database;
//
//    return await db.delete(exerciseTable,
//        where: '${ExerciseFields.id} = ?', whereArgs: [id]);
//  }
//
//  Future close() async {
//    final db = await instance.database;
//
//    db.close();
//  }
//}
//