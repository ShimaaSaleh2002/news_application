import 'package:flutter/material.dart';
import 'package:news_app/ui/screens/home/tabs/tabs_list_tab/news_item.dart';
import '../../../../../data/api_manager.dart';
import '../../../../../data/models/article.dart';
import '../../../../../data/models/articles_response.dart';
import '../../../../../data/models/source.dart';
import '../../../../widgets/error_view.dart';
import '../../../../widgets/loading_view.dart';

class NewsList extends StatelessWidget {
  final Source source;

  const NewsList({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ArticlesResponse?>(
        future: ApiManager.getArticles(source.id!),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorView(
                error: snapshot.error.toString(), onRetryClick: () {});
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

// Widget mapArticleToNewsWidget(BuildContext context, Article article) {
//   return Column(
//     children: [
//       CachedNetworkImage(
//         imageUrl: article.urlToImage ?? "",
//         placeholder: (context, url) => const LoadingView(),
//         errorWidget: (context, url, error) =>const  Icon(Icons.error),
//         height: MediaQuery.of(context).size.height * .25,
//       ),
//       Text(article.source?.name ?? ""),
//       Text(article.title ?? ""),
//       Text(formatTimeAgo(article.publishedAt.toString() ?? ""))
//     ],
//   );
// }
//
// String formatTimeAgo(String dateString) {
//   // Parse the ISO 8601 date string
//   DateTime dateTime = DateTime.parse(dateString);
//
//   // Return the formatted time ago string
//   return timeago.format(dateTime);
// }