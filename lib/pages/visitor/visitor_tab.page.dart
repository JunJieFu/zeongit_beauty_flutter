import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/model/index.model.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor.provider.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor_collection.page.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor_follower.page.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor_following.page.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor_home.page.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor_works.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';

class VisitorTabPage extends StatefulWidget {
  VisitorTabPage({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  _VisitorTabPageState createState() => _VisitorTabPageState();
}

class _VisitorTabPageState extends State<VisitorTabPage>
    with TickerProviderStateMixin {
  TabController _tabController;

  List<TabItemModel> _tabList = [
    TabItemModel(view: VisitorHomePage(), tab: Tab(icon: Icon(MdiIcons.home))),
    TabItemModel(
        view: VisitorWorksPage(), tab: Tab(icon: Icon(MdiIcons.image_outline))),
    TabItemModel(
        view: VisitorCollectionPage(),
        tab: Tab(icon: Icon(MdiIcons.star_outline))),
    TabItemModel(
        view: VisitorFollowerPage(),
        tab: Tab(icon: Icon(MdiIcons.account_heart_outline))),
    TabItemModel(
        view: VisitorFollowingPage(),
        tab: Tab(icon: Icon(MdiIcons.account_star_outline))),
  ];

  UserInfoEntity _user;

  bool _loading = true;

  VisitorState _visitorState = VisitorState();

  Future<void> _get() async {
    var result = await UserService.getByTargetId(widget.id);
    _user = result.data;
    setState(() {
      _loading = false;
    });
    return;
  }

  @override
  void initState() {
    super.initState();
    _visitorState.getInfo(widget.id);
    _tabController = TabController(
      length: _tabList.length,
      vsync: this, //动画效果的异步处理，默认格式，背下来即可
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => _visitorState)],
        child: Consumer<VisitorState>(
            builder: (ctx, VisitorState visitorState, child) {
          return visitorState.info != null
              ? Scaffold(
                  appBar: AppBar(
                    elevation: 1,
                    title: Text(visitorState.info.nickname),
                    bottom: TabBar(
                      controller: _tabController,
                      tabs: _tabList
                          .map((it) => it.tab)
                          .toList(), // <-- total of 2 tabs
                    ),
                  ),
                  body: TabBarView(
                      controller: _tabController,
                      children: _tabList.map((it) => it.view).toList()),
                )
              : Scaffold(body: Container());
        }));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _visitorState.dispose();
    super.dispose();
  }
}