import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/ui/base/base_api_state.dart';
import 'package:news_app/ui/screens/home/tabs/tabs_list_tab/articles_view_model.dart';
import 'package:news_app/ui/screens/home/tabs/tabs_list_tab/news_item.dart';
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
  ArticlesViewModel viewModel = ArticlesViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getArticles(widget.source.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesViewModel, ArticlesViewModelState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state.articlesApiState is BaseSuccessState) {
          BaseSuccessState successState =
              state.articlesApiState as BaseSuccessState<List<Article>?>;
          return buildNewsList(successState.data);
        }else if(state.articlesApiState is BaseErrorState) {
          BaseErrorState errorState = state.articlesApiState as BaseErrorState;
          return ErrorView(
              error: errorState.errorMessage,
              onRetryClick: () {
                viewModel.getArticles(widget.source.id);
              });
        }else{
          return const LoadingView();
        }
      },
    );
  }

  Widget buildNewsList(List<Article> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => NewsItem(article: list[index]));
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
// })
