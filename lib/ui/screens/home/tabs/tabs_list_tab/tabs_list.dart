import 'package:flutter/material.dart';
import 'package:news_app/data/models/category.dart';
import 'package:news_app/data/models/source.dart';
import 'package:news_app/ui/base/base_api_state.dart';
import 'package:news_app/ui/screens/home/tabs/tabs_list_tab/news_list.dart';
import 'package:news_app/ui/screens/home/tabs/tabs_list_tab/tab_item.dart';
import 'package:news_app/ui/screens/home/tabs/tabs_list_tab/tabs_view_model.dart';
import 'package:news_app/ui/widgets/error_view.dart';
import 'package:news_app/ui/widgets/loading_view.dart';
import 'package:provider/provider.dart';

class TabsList extends StatefulWidget {
  final Category category;
  const TabsList({required this.category, super.key});

  @override
  State<TabsList> createState() => _TabsListState();
}

class _TabsListState extends State<TabsList> {
  TabsViewModel viewModel  = TabsViewModel();
  int selectedTabIndex = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSources(widget.category.backEndId);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TabsViewModel>(
      create: (_) => viewModel,
      child: Consumer<TabsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.sourcesState is BaseLoadingState) {
            return const LoadingView();
          } else if (viewModel.sourcesState is BaseErrorState) {
            String error = (viewModel.sourcesState as BaseErrorState).errorMessage;
            return ErrorView(
              error: error,
              onRetryClick: () {
                viewModel.getSources(widget.category.backEndId);
              },
            );
          } else {
            List<Source> sources = (viewModel.sourcesState as BaseSuccessState).data;
            return buildTabsList(sources);
          }
        },
      ),
    );
  }

  Widget buildTabsList(List<Source>? sources) {
    List<Widget> tabs = sources!
        .map((source) => TabItem(
            sourceName: source.name ?? "",
            isSelected: sources?.indexOf(source) == selectedTabIndex))
        .toList();
    List<Widget> tabsContent =
        sources.map((source) => NewsList(source: source)).toList();
    return DefaultTabController(
      length: sources!.length,
      child: Column(
        children: [
          const SizedBox(height: 8),
          TabBar(
            dividerColor: Colors.transparent,
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
}

// FutureBuilder<SourcesResponse?>(
// future: ApiManager.getSources(
// widget.category.backEndId) //calls z function that returns future
// ,
// builder: (context, snapshot) {
// if (snapshot.hasError) {
// //client error ..didn't manage to parse as i've no response..didn't reach the server [catch]
// //no internet connection
// return ErrorView(
// error: snapshot.error.toString(),
// onRetryClick: () {
// ApiManager.getSources(widget.category.backEndId);
// setState(() {});
// });
// } else if (snapshot.hasData) {
// return buildTabsList(snapshot.data!.sources!);
// } else {
// return const LoadingView();
// }
// },
// )