import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/pages/convenient/convenient_tab.page.dart';
import 'package:zeongitbeautyflutter/pages/find/find.page.dart';
import 'package:zeongitbeautyflutter/pages/more/more.page.dart';
import 'package:zeongitbeautyflutter/pages/new/new.page.dart';
import 'package:zeongitbeautyflutter/pages/search/recommend_tag.page.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/lazy_indexed_stack.widget.dart';

class TabPage extends HookWidget {
  TabPage({Key? key}) : super(key: key);

  final _tabList = [
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

  final _findPageController = CustomRefreshController();
  final _newPageController = CustomRefreshController();
  final _tagPageController = CustomRefreshController();
  final _convenientPageController = CustomRefreshController();

  final _preTime = Rx<DateTime?>(null);
  final _tabIndex = 0.obs;

  Future<bool> _pop() {
    if (_preTime.value == null ||
        DateTime.now().difference(_preTime.value!) > Duration(seconds: 2)) {
      _preTime.value = DateTime.now();
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text("再一次返回退出！"),
      ));
      return Future.value(false);
    }
    return Future.value(true);
  }

  _goTop(int index) {
    switch (index) {
      case 0:
        {
          _findPageController.refresh!();
        }
        break;
      case 1:
        {
          _newPageController.refresh!();
        }
        break;
      case 2:
        {
          try {
            _convenientPageController.refresh!();
          } catch (e) {}
        }
        break;
      case 3:
        {
          _tagPageController.refresh!();
        }
        break;
      default:
        {}
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: _tabList.length);

    return WillPopScope(
      onWillPop: _pop,
      child: Scaffold(
          body: Obx(
            () => LazyIndexedStack(
              index: _tabIndex.value,
              itemBuilder: (c, i) {
                if (i == 0)
                  return FindPage(controller: _findPageController);
                else if (i == 1)
                  return NewPage(controller: _newPageController);
                else if (i == 2)
                  return ConvenientTabPage(
                      controller: _convenientPageController);
                else if (i == 3)
                  return RecommendTagPage(controller: _tagPageController);
                else
                  return MorePage();
              },
              itemCount: 5,
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 56,
            child: BottomAppBar(
                child: TabBar(
                    labelStyle: TextStyle(fontSize: 12),
                    tabs: _tabList,
                    controller: tabController,
                    indicatorColor: Colors.transparent,
                    onTap: (int index) {
                      _tabIndex.value = index;
                      if (!tabController.indexIsChanging) {
                        _goTop(index);
                      }
                    })),
          )),
    );
  }
}
