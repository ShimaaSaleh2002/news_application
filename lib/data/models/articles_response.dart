
import 'dart:convert';
import 'article.dart';

ArticlesResponse articlesResponseFromJson(String str) => ArticlesResponse.fromJson(json.decode(str));

String articlesResponseToJson(ArticlesResponse data) => json.encode(data.toJson());

class ArticlesResponse {
    ArticlesResponse({
        required this.totalResults,
        required this.articles,
        required this.status,
    });

    int totalResults;
    List<Article> articles;
    String status;

    factory ArticlesResponse.fromJson(Map<dynamic, dynamic> json) => ArticlesResponse(
        totalResults: json["totalResults"],
        articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
        status: json["status"],
    );

    Map<dynamic, dynamic> toJson() => {
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
        "status": status,
    };
}




enum Id { BLOOMBERG }

final idValues = EnumValues({
    "bloomberg": Id.BLOOMBERG
});

enum Name { BLOOMBERG }

final nameValues = EnumValues({
    "Bloomberg": Name.BLOOMBERG
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
