import 'dart:convert';

import 'package:http/http.dart' ;
import 'package:news_app/data/models/articles_response.dart';
import 'package:news_app/data/models/sources_response.dart';

class ApiManager{

  static const String _baseurl = "https://newsapi.org";
  static const String _apiKey = "1ef53d726bef495689ad268388c4526d";
  static const String _sourcesEndPoint = "/v2/top-headlines/sources";
  static const String _articlesEndPoint = "/v2/everything";

  static Future<SourcesResponse>getSources()async{
    Response serverResponse = await get(Uri.parse('$_baseurl$_sourcesEndPoint?apiKey=$_apiKey')); //link to call the api
    if(serverResponse.statusCode >= 200 && serverResponse.statusCode < 300){
      Map json = jsonDecode(serverResponse.body); //body => function header [ex : status code - body - header]
      SourcesResponse response = SourcesResponse.fromJson(json);
      print('get sources: resources = ${response.sources}'); //make sure that it works properly
      return response;
    }else{
      throw 'sth went wrong!';
    }
  }

  static Future<ArticlesResponse> getArticles(String sourceId)async{
    Response serverResponse = await get(Uri.parse('$_baseurl$_articlesEndPoint?apiKey=$_apiKey&sources=$sourceId'));
    if(serverResponse.statusCode >= 200 && serverResponse.statusCode < 300){
      Map json = jsonDecode(serverResponse.body); //body => function header [ex : status code - body - header]
      return ArticlesResponse.fromJson(json);
    }else{
      throw 'sth went wrong!';
    }
  }
}