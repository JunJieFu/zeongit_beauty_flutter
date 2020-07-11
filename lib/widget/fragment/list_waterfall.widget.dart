import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/style/index.style.dart';
import 'package:zeongitbeautyflutter/pages/detail.page.dart';
import 'package:zeongitbeautyflutter/widget/fragment/picture.widget.dart';

import 'image_ink.widget.dart';

class ListWaterFallWidget extends StatefulWidget {
  ListWaterFallWidget({Key key, this.page, this.list, this.paging})
      : super(key: key);

  final PagePictureEntity page;

  final List<PictureEntity> list;

  final paging;

  @override
  _ListWaterFallWidgetState createState() => _ListWaterFallWidgetState();
}

class _ListWaterFallWidgetState extends State<ListWaterFallWidget> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent -
              _scrollController.position.pixels <
          150) {
        if (widget.paging != null) {
          widget.paging(widget.page.pageable.pageNumber + 2);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WaterfallFlow.builder(
        controller: _scrollController,
        //cacheExtent: 0.0,
        padding: EdgeInsets.all(StyleConfig.listGap),
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: StyleConfig.listGap,
            mainAxisSpacing: StyleConfig.listGap),
        itemCount: widget.list?.length,
        itemBuilder: (BuildContext context, int index) {
          PictureEntity picture = widget.list[index];
          return ImageInkWidget(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(StyleConfig.listGap)),
                child: AspectRatio(
                    aspectRatio: picture.width / picture.height,
                    child: PictureWidget(
                      picture.url,
                      pictureStyle: PictureStyle.specifiedWidth500,
                      fit: BoxFit.cover,
                    )),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return DetailPage(id: picture.id);
                }));
              });
        });
  }
}
