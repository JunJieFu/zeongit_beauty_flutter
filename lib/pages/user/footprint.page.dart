import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/mixins/paging.mixin.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class FootprintPage extends StatefulWidget {
  FootprintPage({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  _FootprintPageState createState() => _FootprintPageState();
}

class _FootprintPageState extends State<FootprintPage>
    with
        RefreshMixin,
        PagingMixin<FootprintPage, PictureEntity, PagePictureEntity>,
        PagePictureMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("足迹")),
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
      FootprintService.paging(pageable, widget.id);

  @override
  TipsPageCard buildEmptyType() {
    return TipsPageCard(
        icon: MdiIcons.shoe_print,
        title: "没有作品",
        text: "您可以前往发现浏览一些系统推荐给您的作品哦。");
  }
}
