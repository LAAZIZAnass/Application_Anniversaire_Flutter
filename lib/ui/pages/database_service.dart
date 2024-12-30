import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  // Singleton pour assurer une seule instance
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  // Méthode pour obtenir la base de données
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('birthdays.db');
    return _database!;
  }

  // Initialisation de la base de données
  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Création de la table
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE birthdays (
        id $idType,
        name $textType,
        date $textType,
        groupName $textType
      )
    ''');
  }

  // Méthodes pour ajouter, mettre à jour et supprimer des anniversaires
  Future<int> addBirthday(Map<String, String> birthday) async {
    final db = await instance.database;
    return await db.insert('birthdays', birthday);
  }

  Future<int> updateBirthday(Map<String, dynamic> updatedBirthday) async {
    final db = await instance.database;
    return await db.update(
      'birthdays',
      updatedBirthday,
      where: 'id = ?',
      whereArgs: [updatedBirthday['id']],
    );
  }

  Future<int> deleteBirthday(int id) async {
    final db = await instance.database;
    return await db.delete(
      'birthdays',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Méthodes pour récupérer les données
  Future<List<Map<String, dynamic>>> getAllBirthdays() async {
    final db = await instance.database;
    return await db.query('birthdays', orderBy: 'id ASC');
  }

  Future<List<Map<String, dynamic>>> getFamilyBirthdays() async {
    final db = await instance.database;
    return await db.query(
      'birthdays',
      where: 'groupName = ?',
      whereArgs: ['Famille'],
      orderBy: 'id ASC',
    );
  }

  Future<List<Map<String, dynamic>>> getFriendsBirthdays() async {
    final db = await instance.database;
    return await db.query(
      'birthdays',
      where: 'groupName = ?',
      whereArgs: ['Amis'],
      orderBy: 'id ASC',
    );
  }

  Future<List<Map<String, dynamic>>> getWorkBirthdays() async {
    final db = await instance.database;
    return await db.query(
      'birthdays',
      where: 'groupName = ?',
      whereArgs: ['Travail'],
      orderBy: 'id ASC',
    );
  }

  // Fermeture de la base de données
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
