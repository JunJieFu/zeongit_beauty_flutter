import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/abstract/page_picture.abstract.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/model/dto.model.dart';
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
  SearchTune _criteria = SearchTune();

  @override
  void initState() {
    super.initState();
    pageable.sort = "updateDate,desc";
    _criteria.precise = null;
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
        title: Text("最新"),
        actions: [
          IconButton(
            icon: Icon(MdiIcons.calendar_month_outline),
            onPressed: _showStartDatePicker,
          ),
          IconButton(
            icon: Icon(MdiIcons.refresh),
            onPressed: (){
              _criteria.date.startDate = null;
              _criteria.date.endDate = null;
              refresh();
            },
          )
        ],
        elevation: 0,
      ),
      body: RefreshIndicator(
          key: refreshIndicatorKey, onRefresh: refresh, child: emptyWidget()),
    );
  }

  @override
  Future<ResultEntity<PagePictureEntity>> dao() =>
      PictureService.paging(pageable, criteria: _criteria);

  @override
  TipsPageCardWidget buildEmptyType() {
    return TipsPageCardWidget(
        icon: MdiIcons.alpha_n_box_outline,
        title: "没有作品",
        text: "难道是系统出现什么问题了。");
  }

  _showStartDatePicker() async {
    var dateTime = await showDatePicker(
        context: context,
        initialDate: _criteria?.date?.startDate ?? DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime.now());
    if (dateTime != null) {
      _criteria.date.startDate = dateTime;
      _criteria.date.endDate = dateTime;
      refresh();
    }
  }
}
