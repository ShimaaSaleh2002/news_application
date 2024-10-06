import 'package:hive_flutter/adapters.dart';
import 'package:news_app/data/models/articles_response.dart';
import 'package:news_app/data/models/sources_response.dart';

class HiveManager{

  static void init()async{
    await Hive.initFlutter();
    Hive.registerAdapter(SourceAdapter());
    Hive.registerAdapter(ArticlesAdapter());
  }


  static Future<void> saveSources(String categoryId, SourcesResponse sourcesResponse)async{
    var box = await Hive.openBox("sourcesList");
    box.put(categoryId, sourcesResponse);
  }
  static Future<SourcesResponse?> getSources(String categoryId)async{
    try{
      var box = await Hive.openBox("sourcesList");
      return box.get(categoryId);
    }catch(e){
      throw "check your internet connection";
      //maybe i opened app with no internet connection
    }
  }

  static Future<void> saveArticles(String sourceId, ArticlesResponse articlesResponse)async{
    var box = await Hive.openBox("articlesList");
    box.put(sourceId, articlesResponse);
  }
  static Future<ArticlesResponse?> getArticles(String sourceId)async{
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