import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/mixins/refresh2.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class CollectionPage extends StatefulWidget {
  CollectionPage({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  CollectionPageState createState() => CollectionPageState();
}

class CollectionPageState extends State<CollectionPage>
    with
        AutomaticKeepAliveClientMixin,
        RefreshMixin,
        PagingMixin<CollectionPage, PictureEntity, PagePictureEntity>,
        PagePictureMixin {
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
      CollectionService.paging(pageable, widget.id);

  @override
  TipsPageCardWidget buildEmptyType() {
    return TipsPageCardWidget(
        icon: MdiIcons.star_outline,
        title: "没有作品",
        text: "您可以前往发现浏览一些系统推荐给您的作品哦。");
  }
}
