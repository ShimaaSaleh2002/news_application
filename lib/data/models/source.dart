
import 'package:news_app/data/models/sources_response.dart';

class Source {
  Source({
    required this.country,
    required this.name,
    required this.description,
    required this.language,
    required this.id,
    required this.category,
    required this.url,
  });

  String country;
  String name;
  String description;
  String language;
  String id;
  Category category;
  String url;

  factory Source.fromJson(Map<dynamic, dynamic> json) => Source(
    country: json["country"],
    name: json["name"],
    description: json["description"],
    language: json["language"],
    id: json["id"],
    category: categoryValues.map[json["category"]]!,
    url: json["url"],
  );

  Map<dynamic, dynamic> toJson() => {
    "country": country,
    "name": name,
    "description": description,
    "language": language,
    "id": id,
    "category": categoryValues.reverse[category],
    "url": url,
  };
}