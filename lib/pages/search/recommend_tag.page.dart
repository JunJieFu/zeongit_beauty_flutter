import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/tag_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/pages/search/search.page.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/image_ink.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/picture.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/title.widget.dart';
import 'package:zeongitbeautyflutter/provider/fragment.logic.dart';

class RecommendTagPage extends HookWidget {
  RecommendTagPage({Key key, this.controller}) : super(key: key);

  final CustomRefreshController controller;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  final fragmentLogic = Get.find<FragmentLogic>();

  @override
  Widget build(BuildContext context) {
    var recommendTagList = useState<List<TagPictureEntity>>([]);

    Future<void> _listTagAndPictureTop30() async {
      var result = await TagService.listTagAndPictureTop30();
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
      body: Obx(
        () => SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: _listTagAndPictureTop30,
          child: ListView(
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              ...(fragmentLogic.searchHistory.length != 0
                  ? [
                      Padding(
                        padding: EdgeInsets.all(StyleConfig.listGap),
                        child: TitleWidget("历史"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(StyleConfig.listGap),
                        child: Wrap(
                            spacing: StyleConfig.listGap,
                            runSpacing: -StyleConfig.gap,
                            children: fragmentLogic.searchHistory
                                    ?.map((item) => ActionChip(
                                        label: Text(item),
                                        onPressed: () {
                                          fragmentLogic.searchPicture(item);
                                        }))
                                    ?.toList() ??
                                <Widget>[]),
                      ),
                      GestureDetector(
                        onTap: () {
                          fragmentLogic.removeHistory();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(StyleConfig.gap),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(MdiIcons.delete_outline),
                              Text("清空搜索历史")
                            ],
                          ),
                        ),
                      ),
                    ]
                  : []),
              Padding(
                padding: EdgeInsets.all(StyleConfig.listGap),
                child: TitleWidget("推荐标签"),
              ),
              GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(StyleConfig.listGap),
                  crossAxisSpacing: StyleConfig.listGap,
                  mainAxisSpacing: StyleConfig.listGap,
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  children: recommendTagList.value
                          ?.map((item) => Stack(children: [
                                ImageInk(
                                  child: AspectRatio(
                                      aspectRatio: 1,
                                      child: PictureWidget(
                                        item.url,
                                        style: PictureStyle.specifiedWidth500,
                                        fit: BoxFit.cover,
                                      )),
                                  onTap: () {
                                    fragmentLogic.searchPicture(item.name);
                                  },
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1,
                                        horizontal: StyleConfig.gap),
                                    decoration: new BoxDecoration(
                                      color: Colors.black38,
                                    ),
                                    child: Center(
                                        child: Text(
                                      item.name,
                                      textScaleFactor: .9,
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                )
                              ]))
                          ?.toList() ??
                      <Widget>[])
            ],
          ),
        ),
      ),
    );
  }
}
