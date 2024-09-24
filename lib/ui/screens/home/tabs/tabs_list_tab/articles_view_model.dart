import 'package:flutter/material.dart';
import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/ui/base/base_api_state.dart';

class ArticlesViewModel extends ChangeNotifier{
  BaseApiState articlesState = BaseLoadingState();

  getArticles(String? sourceId)async{
    try{
      articlesState = BaseLoadingState();
      notifyListeners();
      List<Article>? articles = (await ApiManager.getArticles(sourceId!))?.articles;
      articlesState = BaseSuccessState(data: articles);
      notifyListeners();
    }catch(e){
      articlesState = BaseErrorState(errorMessage: e.toString());
      notifyListeners();
    }
  }
}