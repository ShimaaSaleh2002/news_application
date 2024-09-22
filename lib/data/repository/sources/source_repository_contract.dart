import '../../models/sources_response.dart';

abstract class SourceRepositoryContract{
  Future<SourcesResponse?> getSources(String categoryId);
}