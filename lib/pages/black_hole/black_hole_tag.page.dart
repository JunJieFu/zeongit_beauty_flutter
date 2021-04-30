import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/mixins/refresh2.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/btn/block_tag_icon_btn.widget.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class BlackHoleTagPage extends StatefulWidget {
  @override
  _BlackHoleTagPageState createState() => _BlackHoleTagPageState();
}

class _BlackHoleTagPageState extends State<BlackHoleTagPage>
    with
        AutomaticKeepAliveClientMixin,
        RefreshMixin,
        PagingMixin<BlackHoleTagPage, TagBlackHoleEntity,
            PageTagBlackHoleEntity> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: currPage != null && !currPage.meta.last,
      onRefresh: refresh,
      onLoading: () async {
        await changePage(currPage.meta.currentPage + 1);
      },
      child: _emptyWidget(),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Future<ResultEntity<PageTagBlackHoleEntity>> dao() =>
      TagBlackHoleService.paging(pageable);

  Widget _emptyWidget() {
    if (currPage?.meta != null &&
        currPage.meta.empty &&
        currPage.meta.first &&
        currPage.meta.last) {
      return TipsPageCardWidget(icon: MdiIcons.tag_outline, title: "没有屏蔽标签");
    } else {
      return ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            TagBlackHoleEntity tag = list[index];
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: StyleConfig.gap * 3,
                      vertical: StyleConfig.gap * 2),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: StyleConfig.gap * 2),
                          child: Text(tag.name),
                        ),
                      ),
                      BlockTagIconBtnWidget(
                        tag: tag,
                        callback: (user, int state) {
                          setState(() {
                            list[index].state = state;
                          });
                        },
                      )
                    ],
                  ),
                ),
                Divider(height: 1)
              ],
            );
          });
    }
  }
}
