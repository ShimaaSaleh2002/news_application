import '../../models/articles_response.dart';

abstract class ArticlesRepositoryContract{

  Future<ArticlesResponse?> getArticles(String sourceId);
}