import 'dart:convert';
import 'package:news_app/data/models/source.dart';


SourcesResponse sourcesResponseFromJson(String str) => SourcesResponse.fromJson(json.decode(str));

String sourcesResponseToJson(SourcesResponse data) => json.encode(data.toJson());

class SourcesResponse {
    SourcesResponse({
        required this.sources,
        required this.status,
    });

    List<Source> sources;
    String status;

    factory SourcesResponse.fromJson(Map<dynamic, dynamic> json) => SourcesResponse(
        sources: List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
        status: json["status"],
    );

    Map<dynamic, dynamic> toJson() => {
        "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
        "status": status,
    };
}

enum Category { GENERAL, BUSINESS, TECHNOLOGY, SPORTS, ENTERTAINMENT, HEALTH, SCIENCE }

final categoryValues = EnumValues({
    "business": Category.BUSINESS,
    "entertainment": Category.ENTERTAINMENT,
    "general": Category.GENERAL,
    "health": Category.HEALTH,
    "science": Category.SCIENCE,
    "sports": Category.SPORTS,
    "technology": Category.TECHNOLOGY
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
