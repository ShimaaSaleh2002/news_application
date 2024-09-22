import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/models/articles_response.dart';
import 'package:news_app/data/repository/articles/articles_data_sources.dart';

class ArticlesRemoteDataSourceImpl extends ArticlesRemoteDataSource{

  ApiManager apiManager;
  ArticlesRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<ArticlesResponse?> getArticles(String sourceId) async{
    var response = await apiManager.getArticles(sourceId);
    return response;
  }

}