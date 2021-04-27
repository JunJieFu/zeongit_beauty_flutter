import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/model/index.model.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor.provider.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor_collection.page.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor_follower.page.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor_following.page.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor_home.page.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor_works.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/util/result.util.dart';

class VisitorTabPage extends StatefulWidget {
  VisitorTabPage({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  _VisitorTabPageState createState() => _VisitorTabPageState();
}

class _VisitorTabPageState extends State<VisitorTabPage>
    with TickerProviderStateMixin {
  TabController tabController;

  List<TabItemModel> tabList = [
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

  bool loading = true;

  VisitorState visitorState = VisitorState();

  Future<void> _get() async {
    var result = await UserService.getByTargetId(widget.id);
    if (ResultUtil.check(result)) {
      setState(() {
        loading = false;
      });
      visitorState.setInfo(result.data);
    }
    return;
  }

  @override
  void initState() {
    super.initState();
    _get();
    tabController = TabController(
      length: tabList.length,
      vsync: this, //动画效果的异步处理，默认格式，背下来即可
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => visitorState)],
        child: Consumer<VisitorState>(
            builder: (ctx, VisitorState visitorState, child) {
          return visitorState.info != null
              ? Scaffold(
                  appBar: AppBar(
                    elevation: 1,
                    title: Text(visitorState.info.nickname),
                    bottom: TabBar(
                      controller: tabController,
                      tabs: tabList.map((it) => it.tab).toList(), //
                      indicatorColor:
                          StyleConfig.primaryColor, // <-- total of 2 tabs
                    ),
                  ),
                  body: TabBarView(
                      controller: tabController,
                      children: tabList.map((it) => it.view).toList()),
                )
              : Scaffold(body: Container());
        }));
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
//    visitorState.dispose();
  }
}
