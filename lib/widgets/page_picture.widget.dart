import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/pages/picture/detail_tab_view.page.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/result.util.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/image_ink.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/picture.widget.dart';

typedef ChangePageCallback = Future<void> Function(int pageIndex);

class PagePicture extends StatelessWidget {
  PagePicture({
    Key key,
    @required this.emptyChild,
    @required this.currPage,
    @required this.list,
    @required this.refreshController,
    @required this.refresh,
    @required this.changePage,
  }) : super(key: key);
  final Widget emptyChild;
  final PagePictureEntity currPage;
  final List<PictureEntity> list;
  final RefreshController refreshController;
  final VoidCallback refresh;
  final ChangePageCallback changePage;

  _buildListWaterFall(BuildContext context) {
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
          return ImageInk(
              child: AspectRatio(
                  aspectRatio: aspectRatio,
                  child: PictureWidget(
                    picture.url,
                    style: PictureStyle.specifiedWidth500,
                    fit: BoxFit.cover,
                  )),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return DetailTabViewPage(list:list.map((it)=>it.id).toList(),index:index);
                }));
              },
              onLongPress: () {
                _remove(context, picture.id);
              });
        });
  }

  _remove(BuildContext context, int id) {
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
        return _buildListWaterFall(context);
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
