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
  TabController _tabController;
  GlobalKey<HomePageState> _homePageStateKey = GlobalKey<HomePageState>();
  GlobalKey<FindPageState> _findPageStateKey = GlobalKey<FindPageState>();
  GlobalKey<NewPageState> _newPageStateKey = GlobalKey<NewPageState>();
  GlobalKey<RecommendTagPageState> _tagPageStateKey =
      GlobalKey<RecommendTagPageState>();
  var _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 5,
      vsync: this, //动画效果的异步处理，默认格式，背下来即可
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            LazyIndexedStack(
          index: _tabIndex,
          itemBuilder: (c, i) {
            if (i == 0)
              return HomePage(key: _homePageStateKey);
            else if (i == 1)
              return FindPage(key: _findPageStateKey);
            else if (i == 2)
              return NewPage(key: _newPageStateKey);
            else if (i == 3)
              return RecommendTagPage(key: _tagPageStateKey);
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
                  tabs: _buildTabList(),
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  onTap: (int index) {
                    setState(() {
                      _tabIndex = index;
                    });
                    if (!_tabController.indexIsChanging) {
                      switch (index) {
                        case 0:
                          {
//                          _homePageStateKey.currentState?.externalRefresh();
                          }
                          break;
                        case 1:
                          {
                            _findPageStateKey.currentState?.externalRefresh();
                          }
                          break;
                        case 2:
                          {
                            _newPageStateKey.currentState?.externalRefresh();
                          }
                          break;
                        case 3:
                          {
                            _tagPageStateKey.currentState?.externalRefresh();
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
    _tabController.dispose();
    super.dispose();
  }

  _buildTabList() {
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
}
