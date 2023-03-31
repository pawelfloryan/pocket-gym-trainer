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
CREATE TABLE $sectionTable (
  ${SectionFields.id} $idType,
  ${SectionFields.name} $textType
)
''');
  }

  Future<Section> create(Section section) async {
    final db = await instance.database;
    final id = await db.insert(sectionTable, section.toJson());
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
