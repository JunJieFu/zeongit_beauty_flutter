import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/models/dto.model.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/paging.hook.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widgets/page_picture.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class FindPage extends HookWidget {
  FindPage({Key key, this.controller}) : super(key: key);

  final CustomRefreshController controller;

  @override
  Widget build(BuildContext context) {
    var dateRange = useState(DateRange());

    var pagingHookResult = usePaging<PictureEntity, PagePictureEntity>(
        context,
        (pageable) => PictureService.pagingByRecommend(pageable,
            dateRange: dateRange.value));

    var refreshController = pagingHookResult.refreshController;
    var list = pagingHookResult.list;
    var currPage = pagingHookResult.currPage;
    var refresh = pagingHookResult.refresh;
    var changePage = pagingHookResult.changePage;

    controller?.refresh = () {
      refreshController.value.requestRefresh(duration: const Duration(milliseconds: 200));
    };
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("发现")
        ),
        body: PagePicture(
          currPage: currPage.value,
          list: list.value,
          refreshController: refreshController.value,
          refresh: refresh,
          changePage: changePage,
          emptyChild: TipsPageCard(
              icon: MdiIcons.compass, title: "没有作品", text: "难道是系统出现什么问题了。"),
        ));
  }
}
