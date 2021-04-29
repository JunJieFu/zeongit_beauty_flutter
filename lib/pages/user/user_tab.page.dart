import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/abstract/future_builder_abstract.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/user/collection.page.dart';
import 'package:zeongitbeautyflutter/pages/user/follower.page.dart';
import 'package:zeongitbeautyflutter/pages/user/following.page.dart';
import 'package:zeongitbeautyflutter/pages/user/works.page.dart';
import 'package:zeongitbeautyflutter/pages/user/user_detail.dart';
import 'package:zeongitbeautyflutter/pages/user/user_module.provider.dart';

class UserTabPage extends StatefulWidget {
  UserTabPage({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  _UserTabPageState createState() => _UserTabPageState();
}

class _UserTabPageState extends FutureBuildAbstract<UserTabPage, UserInfoEntity>
    with TickerProviderStateMixin {
  TabController _tabController;

  UserModuleState _userModuleState = UserModuleState();

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
  Future<ResultEntity<UserInfoEntity>> fetchData() async {
    var result =  await UserService.getByTargetId(widget.id);
    _userModuleState.setInfo(result.data);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(futureBuilder());
  }

  _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget buildError(BuildContext context) => _buildLoading();

  @override
  Widget buildMain(BuildContext context, ResultEntity<UserInfoEntity> result) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _userModuleState)
      ],
      child: TabBarView(
        controller: _tabController,
        children: [
          WorksPage(id: result.data.id),
          CollectionPage(id: result.data.id),
          FollowingPage(id: result.data.id),
          FollowerPage(id: result.data.id),
          UserDetailPage(),
        ],
      ),
    );
  }

  @override
  Widget buildSkeleton(BuildContext context) => _buildLoading();

  _buildTabList() {
    return [
      Tab(text: "作品"),
      Tab(text: "收藏"),
      Tab(text: "关注"),
      Tab(text: "粉丝"),
      Tab(text: "详情")
    ];
  }

  _buildScaffold(Widget body) {
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
        body: body);
  }
}
