import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:zeongitbeautyflutter/assets/entity/collection_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/footprint_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/pages/picture/detail_tab_view.page.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/config.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/image_ink.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/picture.widget.dart';
import 'package:zeongitbeautyflutter/provider/picture.logic.dart';
import 'package:zeongitbeautyflutter/widgets/btn/collect_icon_btn.widget.dart';

typedef ChangePageCallback = Future<void> Function(int pageIndex);

final _infoGap = StyleConfig.gap * 3;

_getEmptyPicture(int id, int focus) {
  final picture = PictureEntity();
  var info = UserInfoEntity();
  info.nickname = "无法显示";
  picture.id = id;
  picture.focus = focus;
  picture.name = "无法显示";
  picture.user = info;

  return picture;
}

class PagePicture extends StatelessWidget {
  PagePicture({
    Key? key,
    required this.emptyChild,
    this.meta,
    required this.list,
    required this.refreshController,
    required this.refresh,
    required this.changePage,
    this.callback,
  }) : super(key: key);
  final Widget emptyChild;
  final Meta? meta;
  final RxList<PictureEntity> list;
  final RefreshController refreshController;
  final VoidCallback refresh;
  final ChangePageCallback changePage;
  final Function? callback;

  @override
  Widget build(BuildContext context) {
    return DefaultRefreshConfiguration(
      child: SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: meta != null && !meta!.last,
          onRefresh: refresh,
          onLoading: () async {
            await changePage(meta!.currentPage + 1);
          },
          child: meta != null && meta!.empty && meta!.first && meta!.last
              ? ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [emptyChild])
              : WaterfallFlow.builder(
                  padding: EdgeInsets.all(StyleConfig.listGap),
                  gridDelegate:
                      SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: StyleConfig.listGap,
                          mainAxisSpacing: StyleConfig.listGap),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    PictureLogic logic;
                    try {
                      logic = Get.find(
                          tag: PICTURE_LOGIC_TAG_PREFIX +
                              list[index].id.toString());
                      logic.set(list[index]);
                    } catch (e) {
                      logic = Get.put(PictureLogic(list[index]),
                          tag: PICTURE_LOGIC_TAG_PREFIX +
                              list[index].id.toString());
                    }
                    return Obx(
                      () => Card(
                        child: Column(
                          children: [
                            ImageInk(
                                child: AspectRatio(
                                    aspectRatio: logic.aspectRatio,
                                    child: PictureWidget(
                                      logic.picture!.url,
                                      style: PictureStyle.specifiedWidth500,
                                      fit: BoxFit.cover,
                                    )),
                                onTap: () {
                                  Get.to(DetailTabViewPage(
                                      list: list.map((e) => e.id).toList(),
                                      index: index));
                                },
                                onLongPress: () {
                                  logic.remove();
                                }),
                            Padding(
                              padding: EdgeInsets.all(_infoGap),
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          logic.picture!.name,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(logic.picture!.user.nickname,
                                            overflow: TextOverflow.ellipsis,
                                            textScaleFactor: .8,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color!
                                                    .withOpacity(.56)))
                                      ],
                                    ),
                                    flex: 1,
                                  ),
                                  CollectIconBtn(
                                      id: logic.picture!.id, small: true),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })),
    );
  }
}

class PageCollection extends StatelessWidget {
  PageCollection({
    Key? key,
    required this.emptyChild,
    this.meta,
    required this.list,
    required this.refreshController,
    required this.refresh,
    required this.changePage,
  }) : super(key: key);
  final Widget emptyChild;
  final Meta? meta;
  final List<CollectionEntity> list;
  final RefreshController refreshController;
  final VoidCallback refresh;
  final ChangePageCallback changePage;

  @override
  Widget build(BuildContext context) {
    return DefaultRefreshConfiguration(
      child: SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: meta != null && !meta!.last,
          onRefresh: refresh,
          onLoading: () async {
            await changePage(meta!.currentPage + 1);
          },
          child: meta != null && meta!.empty && meta!.first && meta!.last
              ? ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [emptyChild])
              : WaterfallFlow.builder(
                  padding: EdgeInsets.all(StyleConfig.listGap),
                  gridDelegate:
                      SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: StyleConfig.listGap,
                          mainAxisSpacing: StyleConfig.listGap),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    PictureEntity picture = list[index].picture ??
                        _getEmptyPicture(
                            list[index].pictureId, list[index].focus);
                    PictureLogic logic;
                    try {
                      logic = Get.find(
                          tag:
                              PICTURE_LOGIC_TAG_PREFIX + picture.id.toString());
                      logic.set(picture);
                    } catch (e) {
                      logic = Get.put(PictureLogic(picture),
                          tag:
                              PICTURE_LOGIC_TAG_PREFIX + picture.id.toString());
                    }
                    return Obx(
                      () => Card(
                        child: Column(
                          children: [
                            ImageInk(
                                child: AspectRatio(
                                    aspectRatio: logic.aspectRatio,
                                    child: PictureWidget(
                                      logic.picture!.url,
                                      style: PictureStyle.specifiedWidth500,
                                      fit: BoxFit.cover,
                                    )),
                                onTap: () {
                                  Get.to(DetailTabViewPage(
                                      list:
                                          list.map((e) => e.pictureId).toList(),
                                      index: index));
                                },
                                onLongPress: () {
                                  logic.remove();
                                }),
                            Padding(
                              padding: EdgeInsets.all(_infoGap),
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          logic.picture!.name,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(logic.picture!.user.nickname,
                                            overflow: TextOverflow.ellipsis,
                                            textScaleFactor: .8,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color!
                                                    .withOpacity(.56)))
                                      ],
                                    ),
                                    flex: 1,
                                  ),
                                  CollectIconBtn(
                                      id: logic.picture!.id, small: true),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })),
    );
  }
}

class PageFootprint extends StatelessWidget {
  PageFootprint({
    Key? key,
    required this.emptyChild,
    this.meta,
    required this.list,
    required this.refreshController,
    required this.refresh,
    required this.changePage,
  }) : super(key: key);
  final Widget emptyChild;
  final Meta? meta;
  final List<FootprintEntity> list;
  final RefreshController refreshController;
  final VoidCallback refresh;
  final ChangePageCallback changePage;

  @override
  Widget build(BuildContext context) {
    return DefaultRefreshConfiguration(
      child: SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: meta != null && !meta!.last,
          onRefresh: refresh,
          onLoading: () async {
            await changePage(meta!.currentPage + 1);
          },
          child: meta != null && meta!.empty && meta!.first && meta!.last
              ? ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [emptyChild])
              : WaterfallFlow.builder(
                  padding: EdgeInsets.all(StyleConfig.listGap),
                  gridDelegate:
                      SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: StyleConfig.listGap,
                          mainAxisSpacing: StyleConfig.listGap),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    PictureEntity picture = list[index].picture ??
                        _getEmptyPicture(
                            list[index].pictureId, list[index].focus);
                    PictureLogic logic;
                    try {
                      logic = Get.find(
                          tag:
                              PICTURE_LOGIC_TAG_PREFIX + picture.id.toString());
                      logic.set(picture);
                    } catch (e) {
                      logic = Get.put(PictureLogic(picture),
                          tag:
                              PICTURE_LOGIC_TAG_PREFIX + picture.id.toString());
                    }
                    return Obx(
                      () => Card(
                        child: Column(
                          children: [
                            ImageInk(
                                child: AspectRatio(
                                    aspectRatio: logic.aspectRatio,
                                    child: PictureWidget(
                                      logic.picture!.url,
                                      style: PictureStyle.specifiedWidth500,
                                      fit: BoxFit.cover,
                                    )),
                                onTap: () {
                                  Get.to(DetailTabViewPage(
                                      list:
                                          list.map((e) => e.pictureId).toList(),
                                      index: index));
                                },
                                onLongPress: () {
                                  logic.remove();
                                }),
                            Padding(
                              padding: EdgeInsets.all(_infoGap),
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          logic.picture!.name,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                            logic.picture!.user.nickname,
                                            overflow: TextOverflow.ellipsis,
                                            textScaleFactor: .8,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    !.color
                                                    !.withOpacity(.56)))
                                      ],
                                    ),
                                    flex: 1,
                                  ),
                                  CollectIconBtn(
                                      id: logic.picture!.id, small: true),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })),
    );
  }
}
