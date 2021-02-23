import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor.provider.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/list_waterfall.widget.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class VisitorWorksPage extends StatefulWidget {
  @override
  _VisitorWorksPageState createState() => _VisitorWorksPageState();
}

class _VisitorWorksPageState extends State<VisitorWorksPage>
    with AutomaticKeepAliveClientMixin {
  bool loading = false;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  PagePictureEntity currPage;
  List<PictureEntity> list = [];
  PageableEntity pageable = PageableEntity();
  int targetId;

  Future<void> refresh() async {
    paging(1);
  }

  Future<void> paging(int pageIndex) async {
    pageable.page = pageIndex;
    if (this.loading || (currPage?.meta != null  && currPage.meta.last)) return;
    loading = true;
    var result = await WorksService.paging(pageable, targetId);
    setState(() {
      currPage = result.data;
      list.addAll(currPage.items);
    });
    loading = false;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<VisitorState>(
        builder: (ctx, VisitorState visitorState, child) {
      targetId = visitorState.info.id;
      return RefreshIndicator(
          key: refreshIndicatorKey, onRefresh: refresh, child: emptyWidget());
    });
  }

  Widget emptyWidget() {
    if (currPage?.meta != null && currPage.meta.empty &&
        currPage.meta.first &&
        currPage.meta.last) {
      return TipsPageCardWidget(
          icon: MdiIcons.image_outline,
          title: "没有作品",
          text: "可以上传一些作品到我们哦。");
    } else {
      return ListWaterFallWidget(currPage: currPage, list: list, paging: paging);
    }
  }
}
