import 'package:flutter/material.dart';
import 'package:news_app/data/api_manager.dart';

import '../../../../../data/models/source.dart';

class TabsListViewModel extends ChangeNotifier{
  //holds data - handles logic

  List<Source>? sourceList; //maybe no list
  String? errorMessage;

  void getSources(String categoryId)async{
    //it will draw circular till list comes
    sourceList = null;
    errorMessage = null;
    notifyListeners();
    //try catch instead of futureBuilder
    try{
      var response = await ApiManager.getSources(categoryId);
      if(response?.status == 'error'){
        errorMessage = response?.message;
      }else{
        sourceList = response?.sources;
      }
    }catch(e){
      throw errorMessage = e.toString();
    }
    notifyListeners();
  }

}