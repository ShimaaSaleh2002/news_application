import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/models/source.dart';
import 'package:news_app/ui/base/base_api_state.dart';

class TabsViewModel extends Cubit<TabsViewModelState>{
  TabsViewModel() : super(TabsViewModelState.initial());

  getSources(String categoryId)async{
    try{
      emit(TabsViewModelState(BaseLoadingState()));
      List<Source>? sourcesList =  (await ApiManager.getSources(categoryId))?.sources;
      emit(TabsViewModelState(BaseSuccessState(data: sourcesList)));
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