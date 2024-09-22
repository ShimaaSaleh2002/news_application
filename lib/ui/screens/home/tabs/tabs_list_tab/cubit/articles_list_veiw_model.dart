import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/repository/articles/articles_data_sources.dart';
import 'package:news_app/data/repository/articles/articles_repository_contract.dart';
import 'package:news_app/data/repository/articles/dataSources/articles_remote_data_source_impl.dart';
import 'package:news_app/data/repository/articles/repository/articles_repository_impl.dart';
import 'package:news_app/ui/screens/home/tabs/tabs_list_tab/cubit/news_state.dart';

class ArticlesListViewModel extends Cubit<NewsState>{
  late ApiManager apiManager;
  late ArticlesRepositoryContract repositoryContract;
  late ArticlesRemoteDataSource remoteDataSource;
  ArticlesListViewModel():super(NewsLoadingState()){
    apiManager = ApiManager();
    remoteDataSource = ArticlesRemoteDataSourceImpl
      (apiManager: apiManager);
    repositoryContract = ArticlesRepositoryImpl
      (remoteDataSource: remoteDataSource);
  }

  //todo: hold data .. handle logic
  void getArticles(sourceId) async{
    try{
      emit(NewsLoadingState());
      var response = await repositoryContract.getArticles(sourceId);
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