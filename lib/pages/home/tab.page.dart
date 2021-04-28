import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/pages/find/find.page.dart';
import 'package:zeongitbeautyflutter/pages/account/home.page.dart';
import 'package:zeongitbeautyflutter/pages/new/new.page.dart';
import 'package:zeongitbeautyflutter/pages/more/user.page.dart';
import 'package:zeongitbeautyflutter/pages/search/recommend_tag.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/lazy_indexed_stack.widget.dart';

class TabPage extends StatefulWidget {
  TabPage({Key key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with TickerProviderStateMixin {
  TabController tabController;
  GlobalKey<HomePageState> homePageStateKey = GlobalKey<HomePageState>();
  GlobalKey<FindPageState> findPageStateKey = GlobalKey<FindPageState>();
  GlobalKey<NewPageState> newPageStateKey = GlobalKey<NewPageState>();
  GlobalKey<RecommendTagPageState> tagPageStateKey =
      GlobalKey<RecommendTagPageState>();

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 5,
      vsync: this, //动画效果的异步处理，默认格式，背下来即可
    );
  }

  var _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return Scaffold(
        body:
//            TabBarView(controller: tabController, children: buildTabViewList()),
//            IndexedStack(index: _tabIndex, children: <Widget>[
//          HomePage(key: homePageStateKey),
//          FindPage(key: findPageStateKey),
//          NewPage(key: newPageStateKey),
//          RecommendTagPage(key: tagPageStateKey),
//          UserPage()
//        ]),

            LazyIndexedStack(
          index: _tabIndex,
          itemBuilder: (c, i) {
            if (i == 0)
              return HomePage(key: homePageStateKey);
            else if (i == 1)
              return FindPage(key: findPageStateKey);
            else if (i == 2)
              return NewPage(key: newPageStateKey);
            else if (i == 3)
              return RecommendTagPage(key: tagPageStateKey);
            else
              return UserPage();
          },
          itemCount: 5,
        ),
        bottomNavigationBar: SizedBox(
          height: 56,
          child: BottomAppBar(
              child: TabBar(
                  labelStyle: TextStyle(fontSize: 12),
                  tabs: buildTabList(),
                  controller: tabController,
                  indicatorColor: Colors.transparent,
                  onTap: (int index) {
                    setState(() {
                      _tabIndex = index;
                    });
                    if (!tabController.indexIsChanging) {
                      switch (index) {
                        case 0:
                          {
//                          homePageStateKey.currentState?.externalRefresh();
                          }
                          break;
                        case 1:
                          {
                            findPageStateKey.currentState?.externalRefresh();
                          }
                          break;
                        case 2:
                          {
                            newPageStateKey.currentState?.externalRefresh();
                          }
                          break;
                        case 3:
                          {
                            tagPageStateKey.currentState?.externalRefresh();
                          }
                          break;
                        default:
                          {}
                          break;
                      }
                    }
                  })),
        ));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  buildTabList() {
    return [
      Tab(text: "首页", icon: Icon(MdiIcons.home), iconMargin: EdgeInsets.all(0)),
      Tab(
          text: "推荐",
          icon: Icon(MdiIcons.compass),
          iconMargin: EdgeInsets.all(0)),
      Tab(
          text: "最新",
          icon: Icon(MdiIcons.alpha_n_box_outline),
          iconMargin: EdgeInsets.all(0)),
      Tab(text: "搜索", icon: Icon(Icons.search), iconMargin: EdgeInsets.all(0)),
      Tab(
          text: "更多",
          icon: Icon(MdiIcons.dots_horizontal),
          iconMargin: EdgeInsets.all(0))
    ];
  }

  buildTabViewList() {
    return [
      HomePage(key: homePageStateKey),
      FindPage(key: findPageStateKey),
      NewPage(key: newPageStateKey),
      RecommendTagPage(key: tagPageStateKey),
      UserPage()
    ];
  }
}
