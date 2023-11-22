import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:news_app_with_firebase/model/article_model.dart'; 

class DatabaseHelper {
  late Database _database;

  Future<void> initializeDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'news_app.db');

    _database =
        await openDatabase(databasePath, version: 1, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE articles (id INTEGER PRIMARY KEY, title TEXT, description TEXT, imageUrl TEXT, url TEXT)');
    });
  }

  Future<void> insertArticle(ArticleModel article) async {
    await _database.insert('articles', article.toMap());
  }

  Future<List<ArticleModel>> getArticles() async {
    final List<Map<String, dynamic>> maps = await _database.query('articles');
    return List.generate(
        maps.length, (index) => ArticleModel.fromMap(maps[index]));
  }
}
