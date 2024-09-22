import 'package:news_app/data/models/articles_response.dart';
import 'package:news_app/data/repository/articles/articles_data_sources.dart';
import 'package:news_app/data/repository/articles/articles_repository_contract.dart';

class ArticlesRepositoryImpl extends ArticlesRepositoryContract{

  ArticlesRemoteDataSource remoteDataSource;
  ArticlesRepositoryImpl({required this.remoteDataSource});
  @override
  Future<ArticlesResponse?> getArticles(String sourceId) {
    return remoteDataSource.getArticles(sourceId);
  }

}