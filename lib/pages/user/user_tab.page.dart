import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/pages/user/collection.page.dart';
import 'package:zeongitbeautyflutter/pages/user/follower.page.dart';
import 'package:zeongitbeautyflutter/pages/user/following.page.dart';
import 'package:zeongitbeautyflutter/pages/user/user_detail.dart';
import 'package:zeongitbeautyflutter/pages/user/user_module.getx_ctrl.dart';
import 'package:zeongitbeautyflutter/pages/user/works.page.dart';

class UserTabPage extends HookWidget {
  UserTabPage({Key key, @required this.id}) : super(key: key);

  final int id;

  final List<Tab> _tabList = [
    Tab(text: "作品"),
    Tab(text: "收藏"),
    Tab(text: "关注"),
    Tab(text: "粉丝"),
    Tab(text: "详情")
  ];

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Get.lazyPut(() => UserModuleGetxCtrl(), tag: TAG_PREFIX + id.toString());
      return () {
        Get.delete(tag: TAG_PREFIX + id.toString());
      };
    });

    Widget widget = _buildScaffold(_buildLoading());
    var controller = useTabController(initialLength: _tabList.length);
    var snapshot = useFuture<ResultEntity<UserInfoEntity>>(
        useMemoized(() => UserInfoService.getByTargetId(id)),
        initialData: null);
    if (snapshot.hasData) {
      widget = _buildMain(snapshot.data.data, controller);
    } else {
      widget = _buildScaffold(_buildLoading());
    }
    return widget;
  }

  _buildMain(UserInfoEntity info, TabController controller) {
    final userModuleGetxCtrl =
        Get.find<UserModuleGetxCtrl>(tag: TAG_PREFIX + id.toString());
    userModuleGetxCtrl.setInfo(info);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            tabs: _tabList,
            controller: controller,
          ),
          elevation: 0,
        ),
        body: TabBarView(
          controller: controller,
          children: [
            WorksPage(id: info.id),
            CollectionPage(id: info.id),
            FollowingPage(id: info.id),
            FollowerPage(id: info.id),
            UserDetailPage(id: info.id),
          ],
        ));
  }

  _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  _buildScaffold(Widget body) {
    return Scaffold(body: body);
  }
}
