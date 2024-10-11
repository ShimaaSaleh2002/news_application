import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/data/models/articles_response.dart';
import 'package:news_app/data/repositories/news_repository/news_repository.dart';

import '../../../../base/base_api_state.dart';

@injectable
class ArticlesViewModel extends Cubit<ArticlesViewModelState>{
  NewsRepository newsRepository ;
  ArticlesViewModel(this.newsRepository) : super(ArticlesViewModelState.initial());

  getArticles(String? sourceId)async{
    try{
      emit(ArticlesViewModelState(BaseLoadingState()));
      ArticlesResponse? articlesResponse =
           await newsRepository.getArticles(sourceId!);
      emit(ArticlesViewModelState(BaseSuccessState(data: articlesResponse?.articles)));
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