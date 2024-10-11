import 'package:news_app/data/models/sources_response.dart';

import '../../../models/articles_response.dart';

abstract class NewsOfflineDataSource{

  Future<SourcesResponse?>getSources(String categoryId);

  Future<void> savaSources(String categoryId,SourcesResponse sourcesResponse);

  Future<ArticlesResponse?> getArticles(String sourceId);

  Future<void> saveArticles(String sourceId, ArticlesResponse articlesResponse);

}