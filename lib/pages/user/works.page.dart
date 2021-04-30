import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/mixins/paging.mixin.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class WorksPage extends StatefulWidget {
  WorksPage({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  _WorksPageState createState() => _WorksPageState();
}

class _WorksPageState extends State<WorksPage>
    with
        AutomaticKeepAliveClientMixin,
        RefreshMixin,
        PagingMixin<WorksPage, PictureEntity, PagePictureEntity>,
        PagePictureMixin {
  PageableEntity pageable = PageableEntity(sort: "updateDate,desc");

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
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
      WorksService.paging(pageable, widget.id);

  @override
  TipsPageCardWidget buildEmptyType() {
    return TipsPageCardWidget(
        icon: MdiIcons.image_outline, title: "没有作品", text: "可以上传一些作品到我们哦。");
  }
}
