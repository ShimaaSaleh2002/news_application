import 'package:news_app/data/models/articles_response.dart';

abstract class ArticlesRemoteDataSource{
  Future<ArticlesResponse?> getArticles(String sourceId);
}
abstract class ArticlesOfflineDataSource{}