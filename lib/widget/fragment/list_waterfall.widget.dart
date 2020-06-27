import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';

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
    return WaterfallFlow.builder(
      //cacheExtent: 0.0,
      padding: EdgeInsets.all(5.0),
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 5.0, mainAxisSpacing: 5.0),
      itemBuilder: (context, index) {
        return widget.page?.content ?? Container(
            child: Image.network(
                "http://secdraimg.secdra.com/" +
                    widget.page?.content[index]?.url +
                    "-specifiedWidth",
                fit: BoxFit.cover));
      },
    );
  }
}
