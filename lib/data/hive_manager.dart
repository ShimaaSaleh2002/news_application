import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/data/models/articles_response.dart';
import 'package:news_app/data/models/sources_response.dart';

@injectable
class HiveManager{

  static void init()async{
    await Hive.initFlutter();
    Hive.registerAdapter(SourceAdapter());
    Hive.registerAdapter(ArticlesAdapter());
  }


   Future<void> saveSources(String categoryId, SourcesResponse sourcesResponse)async{
    var box = await Hive.openBox("sourcesList");
    box.put(categoryId, sourcesResponse);
  }

   Future<SourcesResponse?> getSources(String categoryId)async{
    try{
      var box = await Hive.openBox("sourcesList");
      return box.get(categoryId);
    }catch(e){
      throw "check your internet connection";
      //maybe i opened app with no internet connection
    }
  }

   Future<void> saveArticles(String sourceId, ArticlesResponse articlesResponse)async{
    var box = await Hive.openBox("articlesList");
    box.put(sourceId, articlesResponse);
  }
   Future<ArticlesResponse?> getArticles(String sourceId)async{
    try{
      var box = await Hive.openBox("articlesList");
      return box.get(sourceId);
    }catch(e){
      throw "check your internet connection";
    }
  }
}
class SourceAdapter extends TypeAdapter<SourcesResponse>{
  @override
  SourcesResponse read(BinaryReader reader) {
    // TODO: implement read
    return SourcesResponse.fromJson(reader.read());
  }

  @override
  // TODO: implement typeId
  final int typeId = 0;

  @override
  void write(BinaryWriter writer, SourcesResponse obj) {
    // TODO: implement write
    writer.write(obj.toJson());
  }

}

class ArticlesAdapter extends TypeAdapter<ArticlesResponse>{
  @override
  ArticlesResponse read(BinaryReader reader) {
    // TODO: implement read
    return ArticlesResponse.fromJson(reader.read());
  }

  @override
  // TODO: implement typeId
  final int typeId = 1;

  @override
  void write(BinaryWriter writer, ArticlesResponse obj) {
    // TODO: implement write
    writer.write(obj.toJson());
  }

}