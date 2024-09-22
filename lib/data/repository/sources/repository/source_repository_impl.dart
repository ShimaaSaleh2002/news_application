import 'package:news_app/data/models/sources_response.dart';
import 'package:news_app/data/repository/sources/source_data_sources.dart';
import 'package:news_app/data/repository/sources/source_repository_contract.dart';

class SourceRepositoryImpl extends SourceRepositoryContract{
  SourceRemoteDataSource remoteDataSource;
  SourceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<SourcesResponse?> getSources(String categoryId) async{
    return remoteDataSource.getSources(categoryId);
  }

}