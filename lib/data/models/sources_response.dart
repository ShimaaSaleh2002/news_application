import 'package:news_app/data/models/source.dart';

class SourcesResponse {
    SourcesResponse({
        this.status,
        this.message,
        this.code,
        this.sources,
    });

    SourcesResponse.fromJson(dynamic json) {
        status = json['status'];
        code = json['code'];
        message = json['message'];
        if (json['sources'] != null) {
            sources = [];
            json['sources'].forEach((v) {
                sources?.add(Source.fromJson(v));
            });
        }
    }

    String? status;
    List<Source>? sources;
    String? code;

    String? message;

    Map<String, dynamic> toJson() {
        final map = <String, dynamic>{};
        map['status'] = status;
        if (sources != null) {
            map['sources'] = sources?.map((v) => v.toJson()).toList();
        }
        return map;
    }
}
