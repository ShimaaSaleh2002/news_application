import 'article.dart';

class ArticlesResponse {
    ArticlesResponse({
        this.status,
        this.totalResults,
        this.message,
        this.code,
        this.articles,
    });

    ArticlesResponse.fromJson(dynamic json) {
        status = json['status'];
        code = json['code'];
        message = json['message'];
        totalResults = json['totalResults'];
        if (json['articles'] != null) {
            articles = [];
            json['articles'].forEach((v) {
                articles?.add(Article.fromJson(v));
            });
        }
    }

    String? status;
    int? totalResults;
    List<Article>? articles;
    String? code;

    String? message;

    Map<String, dynamic> toJson() {
        final map = <String, dynamic>{};
        map['status'] = status;
        map['totalResults'] = totalResults;
        if (articles != null) {
            map['articles'] = articles?.map((v) => v.toJson()).toList();
        }
        return map;
    }
}
