import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/pages/picture/detail.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/image_ink.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/picture.widget.dart';

// ignore: must_be_immutable
class PictureListWaterfallWidget extends StatefulWidget {
  PictureListWaterfallWidget(
      {Key key,
      this.currPage,
      this.list,
      this.changePage,
      this.controller,
      this.onLongPress})
      : super(key: key) {
    if (controller == null) this.controller = ScrollController();
  }

  final PagePictureEntity currPage;

  final List<PictureEntity> list;

  final Future<void> Function(int) changePage;

  ScrollController controller;

  final void Function(int) onLongPress;

  @override
  PictureListWaterfallWidgetState createState() =>
      PictureListWaterfallWidgetState();
}

class PictureListWaterfallWidgetState
    extends State<PictureListWaterfallWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.position.maxScrollExtent -
              widget.controller.position.pixels <
          150) {
        if (widget.changePage != null) {
          widget.changePage(widget.currPage.meta.currentPage + 1);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WaterfallFlow.builder(
        controller: widget.controller,
        physics: AlwaysScrollableScrollPhysics(),
        //cacheExtent: 0.0,
        padding: EdgeInsets.all(StyleConfig.listGap),
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: StyleConfig.listGap,
            mainAxisSpacing: StyleConfig.listGap),
        itemCount: widget.list?.length,
        itemBuilder: (BuildContext context, int index) {
          PictureEntity picture = widget.list[index];
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
                widget.onLongPress(picture.id);
              });
        });
  }

  jumpTo() {
    widget.controller.jumpTo(0);
  }
}
