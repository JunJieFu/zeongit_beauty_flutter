import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/style/index.style.dart';
import 'package:zeongitbeautyflutter/assets/util/image.util.dart';
import 'package:zeongitbeautyflutter/pages/detail.page.dart';

import 'image_ink.widget.dart';

class ListWaterFallWidget extends StatefulWidget {
  ListWaterFallWidget({Key key, this.page, this.loading, this.pageable})
      : super(key: key);

  final PagePictureEntity page;

  final bool loading;

  final PageableEntity pageable;

  @override
  _ListWaterFallWidgetState createState() => _ListWaterFallWidgetState();
}

class _ListWaterFallWidgetState extends State<ListWaterFallWidget> {
  @override
  Widget build(BuildContext context) {
    return WaterfallFlow(
        //cacheExtent: 0.0,
        padding: EdgeInsets.all(listGap),
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: listGap,
            mainAxisSpacing: listGap),
        children: widget.page?.content?.map((PictureEntity picture) {
              return ImageInkWidget(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(listGap)),
                    child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          ImageUtil.picture(picture.url,
                              type: ImageType.specifiedWidth),
                        )),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return DetailPage(id: picture.id);
                    }));
                  });

//                  Ink(
//                      child: InkWell(
//                child: Container(
//                    child: Image(
//                        image: NetworkImage(ImageUtil.picture("81754094_p0.jpg",
//                            type: ImageType.specifiedWidth)),
//                        fit: BoxFit.cover)),
//                onTap: () {
//                  Navigator.push(context, MaterialPageRoute(builder: (_) {
//                    return DetailPage(id: picture.id);
//                  }));
//                },
//              ));
            })?.toList() ??
            []);
  }
}
