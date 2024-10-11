import 'package:injectable/injectable.dart';
import 'package:news_app/data/repositories/news_repository/news_repository.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:news_app/data/repositories/news_repository/data_sources/news_online_data_source.dart';

import '../../models/articles_response.dart';
import '../../models/sources_response.dart';
import 'data_sources/news_offline_data_source.dart';

@Injectable(as : NewsRepository)
class NewsRepositoryImpl extends NewsRepository{
  NewsOfflineDataSource offlineDataSource ;
  NewsRemoteDataSource remoteDataSource ;
  InternetConnection internetConnection;

  NewsRepositoryImpl(this.offlineDataSource,this.remoteDataSource,this.internetConnection);

  @override
  Future<SourcesResponse?> getSources(String categoryId) async {
    bool isConnected = await internetConnection.hasInternetAccess;

    if (isConnected) {
      SourcesResponse? sourceResponse =
      await remoteDataSource.getSources(categoryId);
      offlineDataSource.savaSources(categoryId, sourceResponse!);
      return sourceResponse;
    } else {
      return offlineDataSource.getSources(categoryId);
    }
  }

  @override
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