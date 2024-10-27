import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'quote.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'quotes.db');

    return await openDatabase(
      path,
      version: 2, // Update the version number if you already have a database.
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE quotes(id INTEGER PRIMARY KEY, quote TEXT, author TEXT, rating INTEGER)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          db.execute('ALTER TABLE quotes ADD COLUMN rating INTEGER DEFAULT 0');
        }
      },
    );
  }

  Future<int> insertQuote(Quote quote) async {
    final db = await database;
    return await db.insert(
      'quotes',
      {
        'id': quote.id,
        'quote': quote.quote,
        'author': quote.author,
        'rating': quote.rating
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Quote>> getFavoriteQuotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('quotes');

    return List.generate(maps.length, (i) {
      return Quote(
        maps[i]['id'],
        maps[i]['quote'],
        maps[i]['author'],
        maps[i]['rating'],
      );
    });
  }

  Future<int> updateQuote(Quote quote) async {
    final db = await database;
    return await db.update(
      'quotes',
      {'quote': quote.quote, 'author': quote.author, 'rating': quote.rating},
      where: 'id = ?',
      whereArgs: [quote.id],
    );
  }
}
