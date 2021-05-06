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

class NewPage extends HookWidget {
  NewPage({Key key, this.controller}) : super(key: key);

  final CustomRefreshController controller;

  @override
  Widget build(BuildContext context) {
    var criteria = useState(SearchPictureTune());
    criteria.value.precise = null;
    var pagingHookResult = usePaging<PictureEntity, PagePictureEntity>(
        context,
        (pageable) =>
            PictureService.paging(pageable, criteria: criteria.value));

    var refreshController = pagingHookResult.refreshController;
    var list = pagingHookResult.list;
    var currPage = pagingHookResult.currPage;
    var refresh = pagingHookResult.refresh;
    var changePage = pagingHookResult.changePage;

    controller?.refresh = () {
      refreshController.value
          .requestRefresh(duration: const Duration(milliseconds: 200));
    };

    dateRefresh({DateTime dateTime}) {
      criteria.value.date.startDate = dateTime;
      criteria.value.date.endDate = dateTime;
      refreshController.value.requestRefresh(needMove: false);
    }

    showStartDatePicker() async {
      var dateTime = await showDatePicker(
          context: context,
          initialDate: criteria.value?.date?.startDate ?? DateTime.now(),
          firstDate: DateTime(2015),
          lastDate: DateTime.now());
      dateRefresh(dateTime: dateTime);
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("最新"),
          actions: [
            IconButton(
              icon: Icon(MdiIcons.calendar_month_outline),
              onPressed: showStartDatePicker,
            ),
            IconButton(
              icon: Icon(MdiIcons.refresh),
              onPressed: dateRefresh,
            )
          ],
        ),
        body: PagePicture(
          currPage: currPage.value,
          list: list.value,
          refreshController: refreshController.value,
          refresh: refresh,
          changePage: changePage,
          emptyChild: TipsPageCard(
              icon: MdiIcons.alpha_n_box_outline,
              title: "没有作品",
              text: "难道是系统出现什么问题了。"),
        ));
  }
}
