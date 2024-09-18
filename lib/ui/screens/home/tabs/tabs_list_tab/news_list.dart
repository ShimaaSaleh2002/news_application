import 'package:flutter/material.dart';
import 'package:news_app/ui/screens/home/tabs/tabs_list_tab/news_item.dart';
import '../../../../../data/api_manager.dart';
import '../../../../../data/models/article.dart';
import '../../../../../data/models/articles_response.dart';
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


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ArticlesResponse?>(
        future: ApiManager.getArticles(widget.source.id!),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorView(
                error: snapshot.error.toString(), onRetryClick: () {
              ApiManager.getArticles(widget.source.id!);
              setState(() {

              });
            });
          } else if (snapshot.hasData) {
            return buildNewsList(snapshot.data!.articles!);
          } else {
            return const LoadingView();
          }
        });
  }

  Widget buildNewsList(List<Article> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) =>
            NewsItem(article: list[index]));
  }
}


