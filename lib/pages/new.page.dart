import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/abstract/page_picture.abstract.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class NewPage extends StatefulWidget {
  NewPage({Key key}) : super(key: key);

  @override
  NewPageState createState() => NewPageState();
}

class NewPageState extends PagePictureAbstract<NewPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    pageable.sort = "updateDate,desc";
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
        key: refreshIndicatorKey, onRefresh: refresh, child: emptyWidget());
  }

  @override
  Future<ResultEntity<PagePictureEntity>> dao() =>
      PictureService.paging(pageable);

  @override
  TipsPageCardWidget buildEmptyType() {
    return TipsPageCardWidget(
        icon: MdiIcons.alpha_n_box_outline,
        title: "没有作品",
        text: "难道是系统出现什么问题了。");
  }
}
