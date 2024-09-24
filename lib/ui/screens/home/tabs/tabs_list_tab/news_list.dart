import 'package:flutter/material.dart';
import 'package:news_app/ui/base/base_api_state.dart';
import 'package:news_app/ui/screens/home/tabs/tabs_list_tab/articles_view_model.dart';
import 'package:news_app/ui/screens/home/tabs/tabs_list_tab/news_item.dart';
import 'package:provider/provider.dart';
import '../../../../../data/models/article.dart';
import '../../../../../data/models/source.dart';
import '../../../../widgets/error_view.dart';
import '../../../../widgets/loading_view.dart';

class NewsList extends StatefulWidget {
  final Source source;

  const NewsList({super.key, required this.source});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  ArticlesViewModel viewModel =ArticlesViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getArticles(widget.source.id);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<ArticlesViewModel>(
          builder: (context, viewModel, child) {
            if(viewModel.articlesState is BaseLoadingState){
              return const LoadingView();
            }else if(viewModel.articlesState is BaseSuccessState){
              List<Article> articles = (viewModel.articlesState as BaseSuccessState).data;
              return buildNewsList(articles);
            }else{
              String error= (viewModel.articlesState as BaseErrorState).errorMessage;
              return ErrorView(error: error, onRetryClick: (){
                viewModel.getArticles(widget.source.id);
              });
            }
          }
        ,),
    );
  }

  Widget buildNewsList(List<Article> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) =>
            NewsItem(article: list[index]));
  }
}

// FutureBuilder<ArticlesResponse?>(
// future: ApiManager.getArticles(widget.source.id!),
// builder: (context, snapshot) {
// if (snapshot.hasError) {
// return ErrorView(
// error: snapshot.error.toString(), onRetryClick: () {
// ApiManager.getArticles(widget.source.id!);
// setState(() {
//
// });
// });
// } else if (snapshot.hasData) {
// return buildNewsList(snapshot.data!.articles!);
// } else {
// return const LoadingView();
// }
// });

