import 'package:flutter/material.dart';
import 'package:news_app/ui/screens/home/tabs/categories/categories_tab.dart';
import 'package:news_app/ui/screens/home/tabs/settings/settings.dart';
import 'package:news_app/ui/screens/home/tabs/tabs_list_tab/tabs_list.dart';
import 'package:news_app/ui/screens/my_theme_data.dart';
import '../../../data/models/category.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Widget currentWidgetBody;

  @override
  void initState(){
    super.initState();
    currentWidgetBody = CategoriesTab(onCategoryClick);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop:()async {
          /// If current tab is categories then we should close the app
          if (currentWidgetBody is CategoriesTab) {
            return true;
          } else {
            /// Here the current is settings or tabs list then
            /// we should navigate back to categories
            currentWidgetBody = CategoriesTab(onCategoryClick);
            setState(() {});
            return false;
          }
        },
        child: Stack(
          children: [
            Container(
              color: MyThemeData.whiteColor,
              child: Image.asset('assets/main_background.png',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: buildAppBar(),
              body : currentWidgetBody,
              drawer: buildDrawer(),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        title: Text('News App',style: Theme.of(context).textTheme.titleLarge),
      toolbarHeight: MediaQuery.of(context).size.height * .08,
    );
  }

  void onCategoryClick(Category category) {
    currentWidgetBody = TabsList(category: category);
    setState(() {});
  }

  buildDrawer() => Drawer(
    //backgroundColor: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildDrawerHeader(),
        buildDrawerRow(Icons.settings, "Settings", () {
          currentWidgetBody = const SettingsTab();
          Navigator.pop(context);
          setState(() {});
        }),
        buildDrawerRow(Icons.list, "Categories", () {
          currentWidgetBody = CategoriesTab(onCategoryClick);
          Navigator.pop(context);
          setState(() {});
        })
      ],
    ),
  );

  Widget buildDrawerHeader() => Container(
      color: Colors.green,
      height: MediaQuery.of(context).size.height * .15,
      child: Center(
          child: Text(
            "NewsApp!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          )));

  buildDrawerRow(IconData iconData, String title, void Function() onClick) =>
      InkWell(
        onTap: () {
          onClick();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                iconData,
                size: 34,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      );

}
