import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zeongitbeautyflutter/abstract/paging.abstract.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor_tab.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/avatar.widget.dart';
import 'package:zeongitbeautyflutter/widget/btn/follow_btn.widget.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

abstract class PageUserAbstract<T extends StatefulWidget>
    extends PagingAbstract<T, UserInfoEntity, PageUserInfoEntity> {
  Widget emptyWidget() {
    if (currPage?.meta != null &&
        currPage.meta.empty &&
        currPage.meta.first &&
        currPage.meta.last) {
      return ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [buildEmptyType()]);
    } else {
      return _buildListWaterFall();
    }
  }

  TipsPageCardWidget buildEmptyType();

  _buildListWaterFall() {
    return ListView.builder(
        controller: scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: list?.length,
        itemBuilder: (BuildContext context, int index) {
          UserInfoEntity user = list[index];
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: StyleConfig.gap * 3,
                    vertical: StyleConfig.gap * 2),
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    _buildAvatar(user),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: StyleConfig.gap * 2),
                        child: Text(user.nickname),
                      ),
                    ),
                    FollowBtn(
                      user: user,
                      callback: (user, int focus) {
                        setState(() {
                          list[index].focus = focus;
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

  InkWell _buildAvatar(UserInfoEntity user) {
    var size = 75.0;
    var padding = 8.0;
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(size / 2)),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: AvatarWidget(
          user?.avatarUrl,
          user?.nickname,
          size: size - padding * 2,
          fit: BoxFit.cover,
          style: AvatarStyle.small50,
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return VisitorTabPage(id: user.id);
        }));
      },
    );
  }
}
