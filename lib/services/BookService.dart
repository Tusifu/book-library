import 'package:ebook_app/models/Book.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BooksDatabase {
  static final BooksDatabase instance = BooksDatabase._init();

  late Database _database;
  BooksDatabase._init();

  Future<Database> get database async {
    _database = await _initDB('books.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future deleteTable() async {
    final db = await database;
    final result = db.delete(tableBooks);
    return result;
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'DOUBLE NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableBooks ( 
  ${BookFields.id} $idType, 
  ${BookFields.title} $textType,
  ${BookFields.book_author} $textType,
  ${BookFields.rating} $textType,
  ${BookFields.book_image} $textType,
  ${BookFields.description} $textType)
''');
  }

  Future<int> create(Book book) async {
    final db = await instance.database;

    final result = await db.insert(tableBooks, book.toJson());
    return result;
  }

  Future<Book> getBookDetail(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableBooks,
      columns: BookFields.values,
      where: '${BookFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Book.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Book>> readAllBooks() async {
    final db = await instance.database;

    const orderBy = '${BookFields.id} DESC';
    final result = await db.query(tableBooks, orderBy: orderBy);

    return result.map((json) => Book.fromJson(json)).toList();
  }

  Future<int> update(Book book) async {
    final db = await instance.database;

    return db.update(
      tableBooks,
      book.toJson(),
      where: '${BookFields.id} = ?',
      whereArgs: [book.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableBooks,
      where: '${BookFields.id} = ?',
      whereArgs: [id],
    );
  }

  // This method return an object if passed uuid exists
  Future<Book> findByBookId(String id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableBooks,
      columns: BookFields.values,
      where: '${BookFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Book.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  // this method return True if passed uuid as args is in the db(sql)
  Future<bool> findByDbMovieId(String id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableBooks,
      columns: BookFields.values,
      where: '${BookFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) return true;
    return false;
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
