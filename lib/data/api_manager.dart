import 'dart:convert';

import 'package:http/http.dart';
import 'package:news_app/data/models/articles_response.dart';
import 'package:news_app/data/models/sources_response.dart';

class ApiManager {
  static const String _baseurl = "https://newsapi.org";
  static const String _apiKey = "1ef53d726bef495689ad268388c4526d";
  static const String _sourcesEndPoint = "/v2/top-headlines/sources";
  static const String _articlesEndPoint = "/v2/everything";


  //loading - success - client error - server error
  // static Future<SourcesResponse> getSources() async {
  //   Uri url = Uri.https(_baseurl, _sourcesEndPoint,
  //   { 'apiKey' : '1ef53d726bef495689ad268388c4526d'});
  //   Response response = await get(url);
  //   try{
  //     Map json = jsonDecode(response.body);
  //     return SourcesResponse.fromJson(json);
  //   }catch(e){
  //     //error from client
  //     //no internet -> server unreachable -> no response
  //     //i won't be able to handle parsing
  //     throw e;
  //   }
  // }

   Future<SourcesResponse?> getSources(String categoryId) async {
    Response serverResponse = await get(Uri.parse(
        '$_baseurl$_sourcesEndPoint?apiKey=$_apiKey&category=$categoryId')); //link to call the api
    if (serverResponse.statusCode >= 200 && serverResponse.statusCode < 300) {
      Map json = jsonDecode(serverResponse
          .body); //body => function header [ex : status code - body - header]
      SourcesResponse response = SourcesResponse.fromJson(json);
      print(
          'get sources: resources = ${response.sources}'); //make sure that it works properly
      return response;
    } else {
      throw 'sth went wrong!';
    }
  }

   Future<ArticlesResponse?> getArticles(String sourceId) async {
    Response serverResponse =
    await get(Uri.parse('$_baseurl$_articlesEndPoint?apiKey=$_apiKey&sources=$sourceId'));
    if (serverResponse.statusCode >= 200 && serverResponse.statusCode < 300) {
      Map json = jsonDecode(serverResponse.body) as Map; //body => function header [ex : status code - body - header]
      return ArticlesResponse.fromJson(json);
    } else {
      throw 'sth went wrong plz try again later!';
    }
  }
}
