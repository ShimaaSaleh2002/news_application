import 'package:news_app/data/models/source.dart';

class Article {
  Article({
    required this.publishedAt,
    required this.author,
    required this.urlToImage,
    required this.description,
    required this.source,
    required this.title,
    required this.url,
    required this.content,
  });

  DateTime publishedAt;
  String author;
  String urlToImage;
  String description;
  Source source;
  String title;
  String url;
  String content;

  factory Article.fromJson(Map<dynamic, dynamic> json) => Article(
    publishedAt: DateTime.parse(json["publishedAt"]),
    author: json["author"],
    urlToImage: json["urlToImage"],
    description: json["description"],
    source: Source.fromJson(json["source"]),
    title: json["title"],
    url: json["url"],
    content: json["content"],
  );

  Map<dynamic, dynamic> toJson() => {
    "publishedAt": publishedAt.toIso8601String(),
    "author": author,
    "urlToImage": urlToImage,
    "description": description,
    "source": source.toJson(),
    "title": title,
    "url": url,
    "content": content,
  };
}