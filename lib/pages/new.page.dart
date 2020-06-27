import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/widget/fragment/list_waterfall.widget.dart';

class NewPage extends StatefulWidget {
  NewPage({Key key}) : super(key: key);

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage>
    with AutomaticKeepAliveClientMixin {
  dynamic _loading = true;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey;
  PagePictureEntity _page;

  Future<void> _paging() async {
    var result = await PictureService.pagingByRecommend(
        PageableEntity(page: 0, size: 16, sort: "createDate,desc"));
    setState(() {
      _page = result.data;
      _loading = false;
    });
    return;
  }

  @override
  void initState() {
    super.initState();
    _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _paging,
      color: Colors.grey,
      backgroundColor: Colors.white,
      child: ListWaterFallWidget(page: _page),
    );
  }
}
