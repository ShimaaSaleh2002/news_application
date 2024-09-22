import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/repository/sources/dataSources/source_remote_data_source_impl.dart';
import 'package:news_app/data/repository/sources/repository/source_repository_impl.dart';
import 'package:news_app/data/repository/sources/source_data_sources.dart';
import 'package:news_app/data/repository/sources/source_repository_contract.dart';
import 'package:news_app/ui/screens/home/tabs/tabs_list_tab/cubit/sources_state.dart';

class TabsListViewModel extends Cubit<SourcesState>{
  late ApiManager apiManager;
  late SourceRepositoryContract repositoryContract;
  late SourceRemoteDataSource remoteDataSource;
  
  TabsListViewModel() : super(SourceLoadingState()){
    apiManager = ApiManager();
    remoteDataSource = SourceRemoteDataSourceImpl(apiManager: apiManager);
    repositoryContract = SourceRepositoryImpl(
        remoteDataSource: remoteDataSource);
  }

  //todo : hold data - handle logic
  getSources(String categoryId)async{
    try{
      emit(SourceLoadingState());
      var response = await repositoryContract.getSources(categoryId);
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