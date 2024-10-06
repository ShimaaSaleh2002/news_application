import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/models/sources_response.dart';
import '../../../models/articles_response.dart';

class NewsRemoteDataSource{

  Future<SourcesResponse?>getSources(String categoryId)async{
    return await ApiManager.getSources(categoryId);
  }

  Future<ArticlesResponse?> getArticles(String sourceId)async{
    return await ApiManager.getArticles(sourceId);
  }
}