import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/models/sources_response.dart';

import '../source_data_sources.dart';

class SourceRemoteDataSourceImpl extends SourceRemoteDataSource{
  ApiManager apiManager;
  SourceRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<SourcesResponse?> getSources(String categoryId) async{
    var response = await apiManager.getSources(categoryId);
    return response;
  }

}