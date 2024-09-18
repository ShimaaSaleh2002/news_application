import 'package:flutter/material.dart';
import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/models/category.dart';
import 'package:news_app/data/models/source.dart';
import 'package:news_app/data/models/sources_response.dart';
import 'package:news_app/ui/screens/home/tabs/tabs_list_tab/news_list.dart';
import 'package:news_app/ui/screens/home/tabs/tabs_list_tab/tab_item.dart';
import 'package:news_app/ui/screens/home/tabs/tabs_list_tab/tabs_list_view_model.dart';
import 'package:news_app/ui/widgets/error_view.dart';
import 'package:news_app/ui/widgets/loading_view.dart';
import 'package:provider/provider.dart';

class TabsList extends StatefulWidget {
  Category category;
  TabsList({required this.category,super.key});

  @override
  State<TabsList> createState() => _TabsListState();
}

class _TabsListState extends State<TabsList> {
  TabsListViewModel viewModel = TabsListViewModel();
  int selectedTabIndex = 0;

  /*
  * to call the function to get data:
  * 1 - inside vm constructor
  * 2 - inside init state
  * */
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSources(widget.category.backEndId);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel, //creates obj of the vm
      child: Consumer<TabsListViewModel>( //listens to viewModel

        //don't wanna redraw the screen
        //const child button icon But listview inside consumer..so rebuild won't
        //affect children ..better performance[like const keyword before constructor in stless]
          builder: (context, viewModel, child) {
            //consumer can check anything inside viewModel as it listens
            //helps me draw widgets depending on vm data
            if(viewModel.errorMessage != null){
              return ErrorView(error: viewModel.errorMessage, onRetryClick: (){
                viewModel.getSources(widget.category.backEndId);
              });
            }
            if(viewModel.sourceList == null){
              return const LoadingView();
            }else{
              return buildTabsList(viewModel.sourceList!);//i'm sure ive a list
            }
          },)
    );
  }

  Widget buildTabsList(List<Source>? sources) {
    List<Widget> tabs = sources!
        .map((source) =>
        TabItem(sourceName: source.name ?? "",isSelected: sources?.indexOf(source) == selectedTabIndex))
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

// Widget mapSourceToTab(Source source, bool isSelected) {
//   return Container(
//     padding: const EdgeInsets.all(12),
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(22),
//         border: Border.all(color: Colors.blue, width: 3),
//         color: isSelected ? Colors.blue : Colors.white),
//     child: Text(
//       source.name ?? "",
//       style: TextStyle(color: isSelected ? Colors.white : Colors.blue),
//     ),
//   );
// }


// FutureBuilder<SourcesResponse?>(
// future: ApiManager.getSources(widget.category.backEndId) //calls z function that returns future
// , builder: (context, snapshot) {
// if (snapshot.hasError) {
// //client error ..didn't manage to parse as i've no response..didn't reach the server [catch]
// //no internet connection
// return ErrorView(error: snapshot.error.toString(), onRetryClick: () {
// ApiManager.getSources(widget.category.backEndId);
// setState(() {
// });
// });
// }else if (snapshot.hasData) {
// return buildTabsList(snapshot.data!.sources!);
// }else {
// return const LoadingView();
// }
// },
// ),