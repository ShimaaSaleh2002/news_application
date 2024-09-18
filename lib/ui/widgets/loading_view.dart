import 'package:flutter/material.dart';
import 'package:news_app/ui/screens/my_theme_data.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: MyThemeData.primaryLightColor,));
  }
}
