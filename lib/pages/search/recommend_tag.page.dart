import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/tag_frequency_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/pages/search/search.page.dart';
import 'package:zeongitbeautyflutter/pages/search/search_tab.page.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';

class RecommendTagPage extends HookWidget {
  RecommendTagPage({Key key, this.controller}) : super(key: key);

  final CustomRefreshController controller;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    var recommendTagList = useState<List<TagFrequencyEntity>>([]);

    Future<void> _listTagTop30() async {
      var result = await TagService.listTagTop30();
      recommendTagList.value = result.data;
      _refreshController.refreshCompleted();
      return;
    }

    controller?.refresh = () {
      _refreshController.requestRefresh(
          duration: const Duration(milliseconds: 200));
    };

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Get.to(SearchPage());
              },
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: _listTagTop30,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(StyleConfig.gap * 2),
                child: Wrap(
                    spacing: StyleConfig.gap * 2,
                    runSpacing: -StyleConfig.gap,
                    children: recommendTagList.value
                            ?.map((e) => ActionChip(
                                label: Text(e.name),
                                onPressed: () {
                                  Get.to(SearchTabPage(keyword: e.name));
                                }))
                            ?.toList() ??
                        <Widget>[]),
              )
            ],
          ),
        ));
  }
}
