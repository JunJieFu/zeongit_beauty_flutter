import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:zeongitbeautyflutter/assets/entity/collection_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/footprint_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_collection_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_footprint_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/pages/picture/detail_tab_view.page.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/result.util.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/comfir.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/config.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/image_ink.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/picture.widget.dart';
import 'package:zeongitbeautyflutter/provider/picture.logic.dart';
import 'package:zeongitbeautyflutter/widgets/btn/collect_icon_btn.widget.dart';

typedef ChangePageCallback = Future<void> Function(int pageIndex);

class PagePicture extends StatelessWidget {
  PagePicture({
    Key key,
    @required this.emptyChild,
    @required this.meta,
    @required this.list,
    @required this.refreshController,
    @required this.refresh,
    @required this.changePage,
    this.callback,
  }) : super(key: key);
  final Widget emptyChild;
  final Meta meta;
  final RxList<PictureEntity> list;
  final RefreshController refreshController;
  final VoidCallback refresh;
  final ChangePageCallback changePage;
  final Function callback;

  _buildListWaterFall() {
    return WaterfallFlow.builder(
        padding: EdgeInsets.all(StyleConfig.listGap),
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: StyleConfig.listGap,
            mainAxisSpacing: StyleConfig.listGap),
        itemCount: list?.length,
        itemBuilder: (BuildContext context, int index) {
          PictureLogic logic;
          try {
            logic = Get.find(
                tag: PICTURE_LOGIC_TAG_PREFIX + list[index].id.toString());
            logic.set(list[index]);
          } catch (e) {
            logic = Get.put(PictureLogic(list[index]),
                tag: PICTURE_LOGIC_TAG_PREFIX + list[index].id.toString());
          }
          return Obx(
            () => Card(
              child: Column(
                children: [
                  ImageInk(
                      child: AspectRatio(
                          aspectRatio: logic.aspectRatio,
                          child: PictureWidget(
                            logic.picture.url,
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
                    padding: EdgeInsets.all(StyleConfig.gap * 3),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                logic.picture.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(logic.picture.user.nickname,
                                  overflow: TextOverflow.ellipsis,
                                  textScaleFactor: .8,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .color
                                          .withOpacity(.56)))
                            ],
                          ),
                          flex: 1,
                        ),
                        CollectIconBtn2(id: logic.picture.id, small: true),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultRefreshConfiguration(
        child: SmartRefresher(
            controller: refreshController,
            enablePullDown: true,
            enablePullUp: meta != null && !meta.last,
            onRefresh: refresh,
            onLoading: () async {
              await changePage(meta.currentPage + 1);
            },
            child: meta != null && meta.empty && meta.first && meta.last
                ? ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [emptyChild])
                : _buildListWaterFall()),
      ),
    );
  }
}

class PageCollection extends StatelessWidget {
  PageCollection({
    Key key,
    @required this.emptyChild,
    @required this.currPage,
    @required this.list,
    @required this.refreshController,
    @required this.refresh,
    @required this.changePage,
  }) : super(key: key);
  final Widget emptyChild;
  final PageCollectionEntity currPage;
  final List<CollectionEntity> list;
  final RefreshController refreshController;
  final VoidCallback refresh;
  final ChangePageCallback changePage;

  _buildListWaterFall() {
    return WaterfallFlow.builder(
        //cacheExtent: 0.0,
        padding: EdgeInsets.all(StyleConfig.listGap),
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: StyleConfig.listGap,
            mainAxisSpacing: StyleConfig.listGap),
        itemCount: list?.length,
        itemBuilder: (BuildContext context, int index) {
          final picture = list[index].picture;
          var aspectRatio =
              picture != null ? picture.width / picture.height : 1.0;
          return Column(
            children: [
              ImageInk(
                  child: AspectRatio(
                      aspectRatio: aspectRatio,
                      child: PictureWidget(
                        picture.url,
                        style: PictureStyle.specifiedWidth500,
                        fit: BoxFit.cover,
                      )),
                  onTap: () {
                    Get.to(DetailTabViewPage(
                        list: list.map((e) => e.pictureId).toList(),
                        index: index));
                  },
                  onLongPress: () {
                    _remove(picture.id);
                  }),
            ],
          );
        });
  }

  _remove(int id) {
    showDialog(
        context: Get.context,
        builder: (ctx) {
          return Confirm(
            title: Text("提示"),
            content: Text("您确定删除该图片吗？"),
            cancelText: Text("取消"),
            confirmText: Text("确定"),
            cancelCallback: Get.back,
            confirmCallback: () async {
              Get.back();
              var result = await PictureService.remove(id);
              if (ResultUtil.check(result)) {
                BotToast.showText(text: "删除成功");
              }
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget buildIf() {
      if (currPage?.meta != null &&
          currPage.meta.empty &&
          currPage.meta.first &&
          currPage.meta.last) {
        return ListView(
            physics: AlwaysScrollableScrollPhysics(), children: [emptyChild]);
      } else {
        return _buildListWaterFall();
      }
    }

    return SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        enablePullUp: currPage != null && !currPage.meta.last,
        onRefresh: refresh,
        onLoading: () async {
          await changePage(currPage.meta.currentPage + 1);
        },
        child: buildIf());
  }
}

class PageFootprint extends StatelessWidget {
  PageFootprint({
    Key key,
    @required this.emptyChild,
    @required this.currPage,
    @required this.list,
    @required this.refreshController,
    @required this.refresh,
    @required this.changePage,
  }) : super(key: key);
  final Widget emptyChild;
  final PageFootprintEntity currPage;
  final List<FootprintEntity> list;
  final RefreshController refreshController;
  final VoidCallback refresh;
  final ChangePageCallback changePage;

  _buildListWaterFall() {
    return WaterfallFlow.builder(
        //cacheExtent: 0.0,
        padding: EdgeInsets.all(StyleConfig.listGap),
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: StyleConfig.listGap,
            mainAxisSpacing: StyleConfig.listGap),
        itemCount: list?.length,
        itemBuilder: (BuildContext context, int index) {
          final picture = list[index].picture;
          var aspectRatio =
              picture != null ? picture.width / picture.height : 1.0;
          return Column(
            children: [
              ImageInk(
                  child: AspectRatio(
                      aspectRatio: aspectRatio,
                      child: PictureWidget(
                        picture?.url,
                        style: PictureStyle.specifiedWidth500,
                        fit: BoxFit.cover,
                      )),
                  onTap: () {
                    Get.to(DetailTabViewPage(
                        list: list.map((e) => e.pictureId).toList(),
                        index: index));
                  },
                  onLongPress: () {
                    _remove(picture.id);
                  }),
            ],
          );
        });
  }

  _remove(int id) {
    showDialog(
        context: Get.context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定删除该图片吗？"),
            actions: <Widget>[
              TextButton(
                  style: TextButton.styleFrom(
                    primary: StyleConfig.warningColor,
                  ),
                  onPressed: Get.back,
                  child: Text("取消")),
              TextButton(
                  onPressed: () async {
                    Get.back();
                    var result = await PictureService.remove(id);
                    if (ResultUtil.check(result)) {
                      BotToast.showText(text: "删除成功");
                    }
                  },
                  child: Text("确定"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget buildIf() {
      if (currPage?.meta != null &&
          currPage.meta.empty &&
          currPage.meta.first &&
          currPage.meta.last) {
        return ListView(
            physics: AlwaysScrollableScrollPhysics(), children: [emptyChild]);
      } else {
        return _buildListWaterFall();
      }
    }

    return DefaultRefreshConfiguration(
      child: SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: currPage != null && !currPage.meta.last,
          onRefresh: refresh,
          onLoading: () async {
            await changePage(currPage.meta.currentPage + 1);
          },
          child: buildIf()),
    );
  }
}
