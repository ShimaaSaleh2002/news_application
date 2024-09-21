import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/ui/screens/home/tabs/tabs_list_tab/cubit/articles_list_veiw_model.dart';
import 'package:news_app/ui/screens/home/tabs/tabs_list_tab/cubit/news_state.dart';
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
ArticlesListViewModel viewModel = ArticlesListViewModel();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getArticles(widget.source.id);
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<ArticlesListViewModel,NewsState>(
          builder: (context, state) {
            if(state is NewsLoadingState){
              return const LoadingView();
            }if(state is NewsSuccessState){
              return buildNewsList(state.articlesList);
            }if(state is NewsErrorState){
              return ErrorView(error: state.errorMessage, onRetryClick: (){
                viewModel.getArticles(widget.source.id);
              });
            }
            return Container();
          },),
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
// })