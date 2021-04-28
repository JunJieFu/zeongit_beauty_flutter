import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/abstract/page_picture.abstract.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor.provider.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class VisitorCollectionPage extends StatefulWidget {
  @override
  _VisitorCollectionPageState createState() => _VisitorCollectionPageState();
}

class _VisitorCollectionPageState
    extends PagePictureAbstract<VisitorCollectionPage>
    with AutomaticKeepAliveClientMixin {
  int _targetId;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<VisitorState>(
        builder: (ctx, VisitorState visitorState, child) {
      _targetId = visitorState.info.id;
      return RefreshIndicator(
          key: refreshIndicatorKey, onRefresh: refresh, child: emptyWidget());
    });
  }

  @override
  TipsPageCardWidget buildEmptyType() => TipsPageCardWidget(
      icon: MdiIcons.star_outline, title: "没有作品", text: "您可以通知作者收藏一些作品哦。");

  @override
  Future<ResultEntity<PagePictureEntity>> dao() =>
      CollectionService.paging(pageable, _targetId);
}
