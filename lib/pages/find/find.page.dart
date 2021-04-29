import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/abstract/page_picture.abstract.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/model/dto.model.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class FindPage extends StatefulWidget {
  FindPage({Key key}) : super(key: key);

  @override
  FindPageState createState() => FindPageState();
}

class FindPageState extends PagePictureAbstract<FindPage>
    with AutomaticKeepAliveClientMixin {
  var _dateRange = DateRange();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicatorKey.currentState?.show();
    });
  }

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
              refresh();
            },
          )
        ],
      ),
      body: RefreshIndicator(
          key: refreshIndicatorKey, onRefresh: refresh, child: emptyWidget()),
    );
  }

  @override
  Future<ResultEntity<PagePictureEntity>> dao() =>
      PictureService.pagingByRecommend(pageable, dateRange: _dateRange);

  @override
  TipsPageCardWidget buildEmptyType() {
    return TipsPageCardWidget(
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
      refresh();
    }
  }
}
