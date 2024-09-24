import 'package:flutter/material.dart';
import 'package:news_app/data/api_manager.dart';
import 'package:news_app/ui/base/base_api_state.dart';

import '../../../../../data/models/source.dart';

class TabsViewModel extends ChangeNotifier{
  BaseApiState sourcesState = BaseLoadingState();

  getSources(String categoryId)async {
    try{
      sourcesState = BaseLoadingState();
      notifyListeners();
      List<Source>? sources = (await ApiManager.getSources(categoryId))?.sources;
      sourcesState = BaseSuccessState(data: sources);
      notifyListeners();
    }catch(e){
      sourcesState = BaseErrorState(errorMessage: e.toString());
      notifyListeners();
    }


  }


}