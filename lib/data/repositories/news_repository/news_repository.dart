import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:news_app/data/models/articles_response.dart';
import 'package:news_app/data/models/sources_response.dart';
import 'package:news_app/data/repositories/news_repository/data_sources/news_offline_data_source.dart';
import 'package:news_app/data/repositories/news_repository/data_sources/news_online_data_source.dart';

class NewsRepository {
  NewsOfflineDataSource offlineDataSource = NewsOfflineDataSource();
  NewsRemoteDataSource remoteDataSource = NewsRemoteDataSource();

  Future<SourcesResponse?> getSources(String categoryId) async {
    bool isConnected = await InternetConnection().hasInternetAccess;

    if (isConnected) {
      SourcesResponse? sourceResponse =
          await remoteDataSource.getSources(categoryId);
      offlineDataSource.savaSources(categoryId, sourceResponse!);
      return sourceResponse;
    } else {
      return offlineDataSource.getSources(categoryId);
    }
  }

  Future<ArticlesResponse?> getArticles(String sourceId)async{
    bool isConnected = await InternetConnection().hasInternetAccess;
    if(isConnected){
      ArticlesResponse? articlesResponse =
          await remoteDataSource.getArticles(sourceId);
      offlineDataSource.saveArticles(sourceId, articlesResponse!);
      return articlesResponse;
    }else{
      return await offlineDataSource.getArticles(sourceId);
    }
  }
}
