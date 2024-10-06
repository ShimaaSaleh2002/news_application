import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/models/article.dart';

import '../../../../base/base_api_state.dart';

class ArticlesViewModel extends Cubit<ArticlesViewModelState>{
  ArticlesViewModel() : super(ArticlesViewModelState.initial());

  getArticles(String? sourceId)async{
    try{
      emit(ArticlesViewModelState(BaseLoadingState()));
      List<Article>? articlesList =  (await ApiManager.getArticles(sourceId!))?.articles;
      emit(ArticlesViewModelState(BaseSuccessState(data: articlesList)));
    }catch(error){
      emit(ArticlesViewModelState(BaseErrorState(errorMessage: error.toString())));
    }
  }

}

class ArticlesViewModelState{
  late BaseApiState articlesApiState;

  ArticlesViewModelState(this.articlesApiState);
  ArticlesViewModelState.initial(){
    articlesApiState = BaseLoadingState();
  }

}