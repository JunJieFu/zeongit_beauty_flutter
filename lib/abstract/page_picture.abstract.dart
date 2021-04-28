import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zeongitbeautyflutter/abstract/paging.abstract.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/util/result.util.dart';
import 'package:zeongitbeautyflutter/widget/picture_list_waterfall.widget.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

abstract class PagePictureAbstract<T extends StatefulWidget>
    extends PagingAbstract<T, PictureEntity, PagePictureEntity> {
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

  TipsPageCardWidget buildEmptyType();

  PictureListWaterfallWidget _buildListWaterFall() {
    return PictureListWaterfallWidget(
      controller: scrollController,
      currPage: currPage,
      list: list,
      changePage: changePage,
      onLongPress: _remove,
    );
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
