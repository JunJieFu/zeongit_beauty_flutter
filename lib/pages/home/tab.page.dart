import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/pages/convenient/convenient_tab.page.dart';
import 'package:zeongitbeautyflutter/pages/find/find.page.dart';
import 'package:zeongitbeautyflutter/pages/more/more.page.dart';
import 'package:zeongitbeautyflutter/pages/new/new.page.dart';
import 'package:zeongitbeautyflutter/pages/search/recommend_tag.page.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/lazy_indexed_stack.widget.dart';

class TabPage extends StatefulWidget {
  TabPage({Key key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with TickerProviderStateMixin {
  TabController _tabController;
  GlobalKey<FindPageState> _findPageStateKey = GlobalKey<FindPageState>();
  GlobalKey<NewPageState> _newPageStateKey = GlobalKey<NewPageState>();
  GlobalKey<ConvenientTabPageState> _convenientPageStateKey =
      GlobalKey<ConvenientTabPageState>();
  GlobalKey<RecommendTagPageState> _tagPageStateKey =
      GlobalKey<RecommendTagPageState>();
  var _tabIndex = 0;
  DateTime _preTime;

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
    return WillPopScope(
      onWillPop: () async {
        if (_preTime == null ||
            DateTime.now().difference(_preTime) > Duration(seconds: 2)) {
          _preTime = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            content: Text("再一次返回退出！"),
          ));
          // BotToast.showText(text: I18n.of(context).return_again_to_exit);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
          body: LazyIndexedStack(
            index: _tabIndex,
            itemBuilder: (c, i) {
              if (i == 0)
                return FindPage(key: _findPageStateKey);
              else if (i == 1)
                return NewPage(key: _newPageStateKey);
              else if (i == 2)
                return ConvenientTabPage(key: _convenientPageStateKey);
              else if (i == 3)
                return RecommendTagPage(key: _tagPageStateKey);
              else
                return MorePage();
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
                              _findPageStateKey.currentState?.externalRefresh();
                            }
                            break;
                          case 1:
                            {
                              _newPageStateKey.currentState?.externalRefresh();
                            }
                            break;
                          case 2:
                            {
                              _convenientPageStateKey.currentState
                                  ?.externalRefresh();
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
          )),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _buildTabList() {
    return [
      Tab(
          text: "发现",
          icon: Icon(MdiIcons.compass),
          iconMargin: EdgeInsets.all(0)),
      Tab(
          text: "最新",
          icon: Icon(MdiIcons.alpha_n_box_outline),
          iconMargin: EdgeInsets.all(0)),
      Tab(text: "速览", icon: Icon(MdiIcons.home), iconMargin: EdgeInsets.all(0)),
      Tab(text: "搜索", icon: Icon(Icons.search), iconMargin: EdgeInsets.all(0)),
      Tab(
          text: "更多",
          icon: Icon(MdiIcons.dots_horizontal),
          iconMargin: EdgeInsets.all(0))
    ];
  }
}
