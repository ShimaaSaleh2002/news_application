import 'package:flutter/material.dart';
import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/models/source.dart';
import 'package:news_app/data/models/sources_response.dart';
import 'package:news_app/ui/screens/home/tabs/news_list.dart';
import 'package:news_app/ui/widgets/error_view.dart';
import 'package:news_app/ui/widgets/loading_view.dart';

class TabsList extends StatefulWidget {
  static const String routeName = 'tab';
  const TabsList({super.key});

  @override
  State<TabsList> createState() => _TabsListState();
}

class _TabsListState extends State<TabsList> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourcesResponse>(
      future: ApiManager.getSources(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorView(error: snapshot.error.toString(), onRetryClick: (){});
        } else if (snapshot.hasData) {
          return buildTabsList(snapshot.data!.sources);
        } else {
          return const LoadingView();
        }
      },
    );
  }

  Widget buildTabsList(List<Source> sources) {
    List<Widget> tabs = sources
        .map((source) => mapSourceToTab(source.name, sources.indexOf(source) == selectedTabIndex))
        .toList();
    List<Widget> tabsContent =
    sources.map((source) => NewsList(source: source)).toList();

    return DefaultTabController(
      length: sources.length,
      child: Column(
        children: [
          const SizedBox(height: 8),
          TabBar(
            indicatorColor: Colors.transparent,
            tabs: tabs,
            isScrollable: true,
            onTap: (index) {
              setState(() {
                selectedTabIndex = index;
              });
            },
          ),
          Expanded(child: TabBarView(children: tabsContent))
        ],
      ),
    );
  }

  Widget mapSourceToTab(String name, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green : Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.green, width: 4),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(color: isSelected ? Colors.white : Colors.green),
        ),
      ),
    );
  }
}
