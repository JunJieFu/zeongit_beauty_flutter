import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/abstract/paging.mixin.dart';
import 'package:zeongitbeautyflutter/abstract/refresh.mixin.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/btn/block_tag_icon_btn.widget.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class BlackHoleTagPage extends StatefulWidget {
  @override
  _BlackHoleTagPageState createState() => _BlackHoleTagPageState();
}

class _BlackHoleTagPageState extends State<BlackHoleTagPage>
    with AutomaticKeepAliveClientMixin, RefreshMixin, PagingMixin {
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
        key: _refreshIndicatorKey, onRefresh: refresh, child: _emptyWidget());
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
          controller: scrollController,
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
