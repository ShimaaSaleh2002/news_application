import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/api_manager.dart';
import 'package:news_app/ui/screens/home/tabs/tabs_list_tab/cubit/news_state.dart';

class ArticlesListViewModel extends Cubit<NewsState>{
  ArticlesListViewModel():super(NewsLoadingState());

  //todo: hold data .. handle logic
  void getArticles(sourceId) async{
    try{
      emit(NewsLoadingState());
      var response = await ApiManager.getArticles(sourceId);
      if(response?.status == 'error'){
        emit(NewsErrorState(errorMessage: response!.message!));
      }if(response?.status == 'ok'){
        emit(NewsSuccessState(articlesList: response!.articles!));
      }
    }catch(e){
      emit(NewsErrorState(errorMessage: e.toString()));
    }

  }

}