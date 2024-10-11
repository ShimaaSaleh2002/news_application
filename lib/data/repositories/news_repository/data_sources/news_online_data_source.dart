import 'package:news_app/data/models/sources_response.dart';
import '../../../models/articles_response.dart';

abstract class NewsRemoteDataSource{

  Future<SourcesResponse?>getSources(String categoryId);

  Future<ArticlesResponse?> getArticles(String sourceId);
}