import 'package:news_app/data/models/articles_response.dart';
import 'package:news_app/data/models/sources_response.dart';

abstract class NewsRepository {

  Future<SourcesResponse?> getSources(String categoryId) ;

  Future<ArticlesResponse?> getArticles(String sourceId);
}
