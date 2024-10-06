import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/models/sources_response.dart';
import 'package:news_app/data/repositories/news_repository/news_repository.dart';
import 'package:news_app/ui/base/base_api_state.dart';

class TabsViewModel extends Cubit<TabsViewModelState>{
  NewsRepository newsRepository = NewsRepository();

  TabsViewModel() : super(TabsViewModelState.initial());

  getSources(String categoryId)async{
    try{
      emit(TabsViewModelState(BaseLoadingState()));
      SourcesResponse? sourcesResponse = await newsRepository.getSources(categoryId);
      emit(TabsViewModelState(BaseSuccessState(data: sourcesResponse?.sources)));
    }catch(error){
      emit(TabsViewModelState(BaseErrorState(errorMessage: error.toString())));
    }

  }
}

class TabsViewModelState{
  late BaseApiState sourcesApiState;
  TabsViewModelState(this.sourcesApiState);

  TabsViewModelState.initial(){
    sourcesApiState = BaseLoadingState();
  }
}