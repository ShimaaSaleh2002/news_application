import 'package:news_app/data/models/article.dart';

abstract class NewsState{}

class NewsLoadingState extends NewsState{}

class NewsErrorState extends NewsState{
  String errorMessage;
  NewsErrorState({required this.errorMessage});

}
class NewsSuccessState extends NewsState{
  List<Article> articlesList;
  NewsSuccessState({required this.articlesList});
}