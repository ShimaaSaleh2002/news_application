import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/api_manager.dart';
import 'package:news_app/ui/screens/home/tabs/tabs_list_tab/cubit/sources_state.dart';

class TabsListViewModel extends Cubit<SourcesState>{
  TabsListViewModel() : super(SourceLoadingState());

  //todo : hold data - handle logic
  getSources(String categoryId)async{
    try{
      emit(SourceLoadingState());
      var response = await ApiManager.getSources(categoryId);
      if(response?.status == 'error'){
        emit(SourceErrorState(errorMessage: response!.message!));
        return;
      }if(response?.status == 'ok') {
        emit(SourceSuccessState(sourcesList: response!.sources!));
        return;
      }
      }catch(e){
      emit(SourceErrorState(errorMessage: e.toString()));
    }
  }

}