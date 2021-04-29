import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/abstract/page_picture.abstract.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class FootprintPage extends StatefulWidget {
  FootprintPage({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  _FootprintPageState createState() => _FootprintPageState();
}

class _FootprintPageState extends PagePictureAbstract<FootprintPage> {
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
        appBar: AppBar(title: Text("足迹")),
        body: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: refresh,
            child: emptyWidget()));
  }

  @override
  Future<ResultEntity<PagePictureEntity>> dao() => FootprintService.paging(pageable, widget.id);

  @override
  TipsPageCardWidget buildEmptyType() {
    return TipsPageCardWidget(
        icon: MdiIcons.shoe_print,
        title: "没有作品",
        text: "您可以前往发现浏览一些系统推荐给您的作品哦。");
  }
}
