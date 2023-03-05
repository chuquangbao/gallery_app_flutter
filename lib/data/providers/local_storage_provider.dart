import 'package:gallery_app_flutter/data/models/bookmark_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalStorageProvider {
  static String bookmarkTbl = 'bookmark_tb';

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    var dbPath = join(databasesPath, 'local_storage.db');
    print(dbPath);
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $bookmarkTbl(id INTEGER PRIMARY KEY, title TEXT, imageUrl TEXT, thumbnailUrl TEXT, timestamp INTEGER)',
        );
      },
    );
  }

  Future<List<BookmarkModel>> getBookmarks({
    int limit = 30,
    int offset = 0,
  }) async {
    final db = await database;
    var res = await db?.query(
      bookmarkTbl,
      limit: limit,
      offset: offset,
      orderBy: 'timestamp DESC',
    );
    var isEmpty = res?.isEmpty == true;
    var list = res!.isNotEmpty
        ? res.map((dynamic c) {
            print(c);
            var entity = BookmarkModel.fromJson(c as Map<String, dynamic>);
            return entity;
          }).toList()
        : <BookmarkModel>[];
    return list;
  }

  Future<bool> addBookmark(BookmarkModel bookmark) async {
    final db = await database;
    var result = await db?.insert(bookmarkTbl, bookmark.toJson()) ?? -1;
    return Future.value(result > 0 ? true : false);
  }

  Future<bool> removeBookmark(int bookmarkId) async {
    final db = await database;
    var result = await db
            ?.delete(bookmarkTbl, where: 'id = ?', whereArgs: [bookmarkId]) ??
        -1;
    return Future.value(result > 0 ? true : false);
  }

  Future<bool> isBookmark(int bookmarkId) async {
    final db = await database;
    var result = await db?.rawQuery(
        'SELECT COUNT(*) FROM $bookmarkTbl WHERE id = ?', [bookmarkId]);
    if (result != null) {
      var count = Sqflite.firstIntValue(result) ?? 0;
      var isFavorite = count > 0 == true;
      return isFavorite;
    } else {
      return false;
    }
  }
}
