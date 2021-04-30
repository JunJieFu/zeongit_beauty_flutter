import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/picture/detail.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/util/result.util.dart';
import 'package:zeongitbeautyflutter/plugins/widget/image_ink.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/picture.widget.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

abstract class RefreshAbstract<T extends StatefulWidget> extends State<T> {
  RefreshController refreshController;

  externalRefresh();
}

mixin RefreshMixin<T extends StatefulWidget> on State<T>
    implements RefreshAbstract<T> {
  @override
  RefreshController refreshController = RefreshController(initialRefresh: true);

  @override
  externalRefresh() {
    refreshController.requestRefresh(
        duration: const Duration(milliseconds: 200));
  }
}

abstract class PagingAbstract<T extends StatefulWidget, M, P extends dynamic>
    extends RefreshAbstract<T> {
  bool loading;
  P currPage;
  List<M> list;
  PageableEntity pageable;

  Future<void> refresh();

  Future<void> changePage(int pageIndex);

  Future<void> paging();

  Future<ResultEntity<dynamic>> dao();
}

mixin PagingMixin<T extends StatefulWidget, M, P extends dynamic> on State<T>
    implements PagingAbstract<T, M, P> {
  @override
  bool loading = false;
  @override
  P currPage;
  @override
  List<M> list = [];
  @override
  PageableEntity pageable = PageableEntity();

  @override
  Future<void> refresh() async {
    pageable.page = 1;
    paging();
  }

  @override
  Future<void> changePage(int pageIndex) async {
    if (currPage?.meta != null && currPage.meta.last ||
        currPage?.meta != null && currPage.meta.currentPage >= pageIndex)
      return;
    pageable.page = pageIndex;
    paging();
  }

  @override
  Future<void> paging() async {
    if (loading) return;
    loading = true;
    var result = await dao();
    setState(() {
      currPage = result.data;
      if (currPage.meta.first) {
        refreshController.position.jumpTo(0);
        list = currPage.items as List<M>;
      } else {
        list.addAll(currPage.items as List<M>);
      }
    });
    loading = false;
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  @override
  Future<ResultEntity<dynamic>> dao();
}

abstract class PagePictureAbstract<T extends StatefulWidget>
    extends PagingAbstract<T, PictureEntity, PagePictureEntity> {
  Widget emptyWidget();

  TipsPageCardWidget buildEmptyType();
}

mixin PagePictureMixin<T extends StatefulWidget> on State<T>
    implements PagePictureAbstract<T> {
  @override
  Widget emptyWidget() {
    if (currPage?.meta != null &&
        currPage.meta.empty &&
        currPage.meta.first &&
        currPage.meta.last) {
      return ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [buildEmptyType()]);
    } else {
      return _buildListWaterFall();
    }
  }

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
          PictureEntity picture = list[index];
          var aspectRatio = 1.0;
          if (picture.width != 0 && picture.height != 0) {
            aspectRatio = picture.width / picture.height;
          }
          return ImageInkWidget(
              child: AspectRatio(
                  aspectRatio: aspectRatio,
                  child: PictureWidget(
                    picture.url,
                    style: PictureStyle.specifiedWidth500,
                    fit: BoxFit.cover,
                  )),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return DetailPage(id: picture.id);
                }));
              },
              onLongPress: () {
                _remove(picture.id);
              });
        });
  }

  _remove(int id) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定删除该图片吗？"),
            actions: <Widget>[
              TextButton(
                  style: TextButton.styleFrom(
                    primary: StyleConfig.warningColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(this);
                  },
                  child: Text("取消")),
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(this);
                    var result = await PictureService.remove(id);
                    if (ResultUtil.check(result)) {
                      Fluttertoast.showToast(
                          msg: "删除成功",
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: StyleConfig.successColor);
                    }
                  },
                  child: Text("确定"))
            ],
          );
        });
  }
}
