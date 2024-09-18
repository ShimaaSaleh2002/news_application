import 'package:flutter/material.dart';
import 'package:news_app/ui/screens/my_theme_data.dart';

class Category {
  String backEndId;
  String title;
  String imagePath;
  bool isLeftSided;
  Color backgroundColor;

  Category(
      {required this.backEndId,
        required this.title,
        required this.imagePath,
        required this.isLeftSided,
        required this.backgroundColor});

  static List<Category> categories = [
    Category(
        backEndId: "sports",
        title: "Sports",
        imagePath: "assets/ball.png",
        isLeftSided: true,
        backgroundColor: MyThemeData.redColor),
    Category(
        backEndId: "technology",
        title: "Technology",
        imagePath: "assets/Politics.png",
        isLeftSided: false,
        backgroundColor: MyThemeData.darkBlueColor),
    Category(
        backEndId: "health",
        title: "Health",
        imagePath: "assets/health.png",
        isLeftSided: true,
        backgroundColor: MyThemeData.pinkColor),
    Category(
        backEndId: "business",
        title: "Business",
        imagePath: "assets/bussines.png",
        isLeftSided: false,
        backgroundColor: MyThemeData.brownColor),
    Category(
        backEndId: "entertainment",
        title: "Entertainment",
        imagePath: "assets/environment.png",
        isLeftSided: true,
        backgroundColor: MyThemeData.blueColor),
    Category(
        backEndId: "science",
        title: "Science",
        imagePath: "assets/science.png",
        isLeftSided: false,
        backgroundColor: MyThemeData.yellowColor)
  ];
}
