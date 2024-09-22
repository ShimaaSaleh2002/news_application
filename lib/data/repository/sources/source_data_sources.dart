import 'package:news_app/data/models/sources_response.dart';

abstract class SourceRemoteDataSource{
  Future<SourcesResponse?> getSources(String categoryId);
}

abstract class SourceOfflineDataSource{}