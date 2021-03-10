import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/pages/picture/detail.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/image_ink.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/picture.widget.dart';

class PictureListWaterfallWidget extends StatefulWidget {
  PictureListWaterfallWidget(
      {Key key, this.currPage, this.list, this.paging, this.onLongPress})
      : super(key: key);

  final PagePictureEntity currPage;

  final List<PictureEntity> list;

  final paging;

  final void Function(int) onLongPress;

  @override
  PictureListWaterfallWidgetState createState() =>
      PictureListWaterfallWidgetState();
}

class PictureListWaterfallWidgetState
    extends State<PictureListWaterfallWidget> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent -
              scrollController.position.pixels <
          150) {
        if (widget.paging != null) {
          widget.paging(widget.currPage.meta.currentPage + 1);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WaterfallFlow.builder(
        controller: scrollController,
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
              onLongPress: (){
                widget.onLongPress(picture.id);
              });
        });
  }

  goTo() {
    scrollController.jumpTo(0);
  }
}
