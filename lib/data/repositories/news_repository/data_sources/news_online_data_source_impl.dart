import 'package:injectable/injectable.dart';
import 'package:news_app/data/repositories/news_repository/data_sources/news_online_data_source.dart';

import '../../../api_manager.dart';
import '../../../models/articles_response.dart';
import '../../../models/sources_response.dart';

@Injectable(as : NewsRemoteDataSource)
class NewsOnlineDataSourceImpl extends NewsRemoteDataSource{
  ApiManager apiManager;
  NewsOnlineDataSourceImpl(this.apiManager);
  @override
  Future<SourcesResponse?>getSources(String categoryId)async{
    return await apiManager.getSources(categoryId);
  }

  @override
  Future<ArticlesResponse?> getArticles(String sourceId)async{
    return await apiManager.getArticles(sourceId);
  }
}