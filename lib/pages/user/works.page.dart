import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/abstract/page_picture.abstract.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class WorksPage extends StatefulWidget {
  WorksPage({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  _WorksPageState createState() => _WorksPageState();
}

class _WorksPageState extends PagePictureAbstract<WorksPage>
    with AutomaticKeepAliveClientMixin {
  PageableEntity pageable = PageableEntity(sort: "updateDate,desc");

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
    return Scaffold(
        body: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: refresh,
            child: emptyWidget()));
  }

  @override
  Future<ResultEntity<PagePictureEntity>> dao() =>
      WorksService.paging(pageable, widget.id);

  @override
  TipsPageCardWidget buildEmptyType() {
    return TipsPageCardWidget(
        icon: MdiIcons.image_outline, title: "没有作品", text: "可以上传一些作品到我们哦。");
  }
}
