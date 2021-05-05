import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/models/dto.model.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/mixins/paging.mixin.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class FindPage extends StatefulWidget {
  FindPage({Key key}) : super(key: key);

  @override
  FindPageState createState() => FindPageState();
}

class FindPageState extends State<FindPage>
    with
        AutomaticKeepAliveClientMixin,
        RefreshMixin,
        PagingMixin<FindPage, PictureEntity, PagePictureEntity>,
        PagePictureMixin {
  var _dateRange = DateRange();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("发现"),
          actions: [
            IconButton(
              icon: Icon(MdiIcons.calendar_month_outline),
              onPressed: _showStartDatePicker,
            ),
            IconButton(
              icon: Icon(MdiIcons.refresh),
              onPressed: () {
                _dateRange.startDate = null;
                _dateRange.endDate = null;
                refreshController.requestRefresh(needMove: false);
              },
            )
          ],
        ),
        body: SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: currPage != null && !currPage.meta.last,
          onRefresh: refresh,
          onLoading: () async {
            await changePage(currPage.meta.currentPage + 1);
          },
          child: emptyWidget(),
        ));
  }

  @override
  Future<ResultEntity<PagePictureEntity>> dao() =>
      PictureService.pagingByRecommend(pageable, dateRange: _dateRange);

  @override
  TipsPageCard buildEmptyType() {
    return TipsPageCard(
        icon: MdiIcons.compass, title: "没有作品", text: "难道是系统出现什么问题了。");
  }

  _showStartDatePicker() async {
    var dateTime = await showDatePicker(
        context: context,
        initialDate: _dateRange?.startDate ?? DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime.now());
    if (dateTime != null) {
      _dateRange.startDate = dateTime;
      _dateRange.endDate = dateTime;
      refreshController.requestRefresh(needMove: false);
    }
  }
}
