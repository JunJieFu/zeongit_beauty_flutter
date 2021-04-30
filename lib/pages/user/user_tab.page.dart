import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/abstract/future_builder_mixin.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/user/collection.page.dart';
import 'package:zeongitbeautyflutter/pages/user/follower.page.dart';
import 'package:zeongitbeautyflutter/pages/user/following.page.dart';
import 'package:zeongitbeautyflutter/pages/user/user_detail.dart';
import 'package:zeongitbeautyflutter/pages/user/user_module.provider.dart';
import 'package:zeongitbeautyflutter/pages/user/works.page.dart';

class UserTabPage extends StatefulWidget {
  UserTabPage({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  _UserTabPageState createState() => _UserTabPageState();
}

class _UserTabPageState extends State<UserTabPage>
    with FutureBuilderMixin<UserTabPage, UserInfoEntity> {
  @override
  Future<ResultEntity<UserInfoEntity>> fetchData() async {
    var result = await UserService.getByTargetId(widget.id);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return futureBuilder();
  }

  _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget buildError(BuildContext context) => _buildScaffold(_buildLoading());

  @override
  Widget buildMain(BuildContext context, ResultEntity<UserInfoEntity> result) {
    return _UserTabBuildPage(info: result.data);
  }

  @override
  Widget buildSkeleton(BuildContext context) => _buildScaffold(_buildLoading());

  _buildScaffold(Widget body) {
    return Scaffold(body: body);
  }
}

class _UserTabBuildPage extends StatefulWidget {
  _UserTabBuildPage({Key key, @required this.info}) : super(key: key);

  final UserInfoEntity info;

  @override
  _UserTabBuildPageState createState() => _UserTabBuildPageState();
}

// 由于TickerProviderStateMixin和FutureBuild有一些莫名其妙的问题
class _UserTabBuildPageState extends State<_UserTabBuildPage>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 5,
      vsync: this, //动画效果的异步处理，默认格式，背下来即可
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            tabs: _buildTabList(),
            controller: _tabController,
          ),
          elevation: 0,
        ),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (context) => UserModuleState(info: widget.info))
          ],
          child: TabBarView(
            controller: _tabController,
            children: [
              WorksPage(id: widget.info.id),
              CollectionPage(id: widget.info.id),
              FollowingPage(id: widget.info.id),
              FollowerPage(id: widget.info.id),
              UserDetailPage(),
            ],
          ),
        ));
  }

  _buildTabList() {
    return [
      Tab(text: "作品"),
      Tab(text: "收藏"),
      Tab(text: "关注"),
      Tab(text: "粉丝"),
      Tab(text: "详情")
    ];
  }
}
