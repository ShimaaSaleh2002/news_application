import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/ui/screens/my_theme_data.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../widgets/loading_view.dart';

class NewsItem extends StatelessWidget {
  final Article article;
  const NewsItem({super.key,required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              width: double.infinity,
              imageUrl: article.urlToImage ?? "",
              placeholder: (context, url) => const LoadingView(),
              errorWidget: (context, url, error) =>const  Icon(Icons.error),
              height: MediaQuery.of(context).size.height * .25,
            ),
          ),
          Text(article.source?.name ?? "",style:Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: MyThemeData.greyColor)),
          Text(article.title ?? "",style: Theme.of(context).textTheme.titleMedium),
          Row(
            children: [
              const Spacer(),
              Text(formatTimeAgo(article.publishedAt.toString()??""),style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: MyThemeData.greyColor),),
            ],
          )
        ],
      ),
    );
  }
  String formatTimeAgo(String dateString) {
    // Parse the ISO 8601 date string
    DateTime dateTime = DateTime.parse(dateString);

    // Return the formatted time ago string
    return timeago.format(dateTime);
  }
}
