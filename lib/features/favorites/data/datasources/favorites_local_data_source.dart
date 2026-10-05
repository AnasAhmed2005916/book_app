import 'dart:convert';

import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesLocalDataSource {
  static const String _databaseName = 'bookly.db';
  static const String _tableName = 'favorites';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    return openDatabase(
      path,
      version: 1,
      onCreate: (database, version) async {
        await database.execute('''
          CREATE TABLE $_tableName (
            key TEXT PRIMARY KEY,
            title TEXT,
            author_name TEXT,
            first_publish_year INTEGER,
            cover_i INTEGER,
            subject TEXT
          )
        ''');
      },
    );
  }

  Future<void> addFavorite(BookModel book) async {
    final database = await this.database;

    await database.insert(_tableName, {
      'key': book.key,
      'title': book.title,
      'author_name': jsonEncode(book.authorName ?? []),
      'first_publish_year': book.firstPublishYear,
      'cover_i': book.coverId,
      'subject': jsonEncode(book.subjects ?? []),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeFavorite(String key) async {
    final database = await this.database;

    await database.delete(_tableName, where: 'key = ?', whereArgs: [key]);
  }

  Future<List<BookModel>> getFavorites() async {
    final database = await this.database;

    final data = await database.query(_tableName, orderBy: 'rowid DESC');

    return data.map((item) {
      final authorName = item['author_name'] as String?;
      final subjects = item['subject'] as String?;

      final decodedAuthors = authorName != null ? jsonDecode(authorName) : null;

      final decodedSubjects = subjects != null ? jsonDecode(subjects) : null;

      return BookModel(
        key: item['key'] as String?,
        title: item['title'] as String?,
        authorName: decodedAuthors is List
            ? List<String>.from(decodedAuthors)
            : null,
        firstPublishYear: item['first_publish_year'] as int?,
        coverId: item['cover_i'] as int?,
        subjects: decodedSubjects is List
            ? List<String>.from(decodedSubjects)
            : null,
        isFavorite: true,
      );
    }).toList();
  }

  Future<bool> isFavorite(String key) async {
    final database = await this.database;

    final result = await database.query(
      _tableName,
      columns: ['key'],
      where: 'key = ?',
      whereArgs: [key],
      limit: 1,
    );

    return result.isNotEmpty;
  }
}
