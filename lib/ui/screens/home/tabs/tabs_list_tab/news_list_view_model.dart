import 'package:flutter/material.dart';
import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/models/article.dart';

class NewsListViewModel extends ChangeNotifier{

  //hold data .. handle logic
  List<Article>? articlesList;
  String? errorMessage;

  getArticles(String sourceId)async{
    articlesList = null;
    errorMessage = null;
    notifyListeners();
    try{
      var response = await ApiManager.getArticles(sourceId);
      if(response?.status == 'ok'){
        articlesList = response!.articles;
      }else{
        errorMessage = response!.message;
      }
    }catch(e){
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}