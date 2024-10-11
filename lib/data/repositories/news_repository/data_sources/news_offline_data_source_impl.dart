import 'package:injectable/injectable.dart';
import 'package:news_app/data/repositories/news_repository/data_sources/news_offline_data_source.dart';

import '../../../hive_manager.dart';
import '../../../models/articles_response.dart';
import '../../../models/sources_response.dart';

@Injectable(as : NewsOfflineDataSource)
class NewsOfflineDataSourceImpl extends NewsOfflineDataSource{

  HiveManager hiveManager;
  NewsOfflineDataSourceImpl(this.hiveManager);

  @override
  Future<SourcesResponse?>getSources(String categoryId)async{
    return await hiveManager.getSources(categoryId);
  }

  @override
  Future<void> savaSources(String categoryId,SourcesResponse sourcesResponse)async{
    return await hiveManager.saveSources(categoryId, sourcesResponse);
  }

  @override
  Future<ArticlesResponse?> getArticles(String sourceId)async{
    return await hiveManager.getArticles(sourceId);
  }

  @override
  Future<void> saveArticles(String sourceId, ArticlesResponse articlesResponse)async{
    return await hiveManager.saveArticles(sourceId, articlesResponse);
  }
}