import 'package:news_app/data/hive_manager.dart';
import 'package:news_app/data/models/sources_response.dart';

import '../../../models/articles_response.dart';

class NewsOfflineDataSource{

  Future<SourcesResponse?>getSources(String categoryId)async{
    return await HiveManager.getSources(categoryId);
  }

  Future<void> savaSources(String categoryId,SourcesResponse sourcesResponse)async{
    return await HiveManager.saveSources(categoryId, sourcesResponse);
  }

  Future<ArticlesResponse?> getArticles(String sourceId)async{
    return await HiveManager.getArticles(sourceId);
  }

  Future<void> saveArticles(String sourceId, ArticlesResponse articlesResponse)async{
    return await HiveManager.saveArticles(sourceId, articlesResponse);
  }

}