import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor_tab.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/avatar.widget.dart';
import 'package:zeongitbeautyflutter/widget/btn/follow_btn.widget.dart';

// ignore: must_be_immutable
class UserListNormalWidget extends StatefulWidget {
  UserListNormalWidget({
    Key key,
    this.currPage,
    this.list,
    this.changePage,
    this.controller,
  }) : super(key: key) {
    if (controller == null) this.controller = ScrollController();
  }

  final PageUserInfoEntity currPage;

  final List<UserInfoEntity> list;

  final Future<void> Function(int) changePage;

  ScrollController controller;

  @override
  UserListNormalWidgetState createState() => UserListNormalWidgetState();
}

class UserListNormalWidgetState extends State<UserListNormalWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.position.maxScrollExtent -
              widget.controller.position.pixels <
          150) {
        if (widget.changePage != null) {
          widget.changePage(widget.currPage.meta.currentPage + 1);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: widget.controller,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: widget.list?.length,
        itemBuilder: (BuildContext context, int index) {
          UserInfoEntity user = widget.list[index];
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
                          widget.list[index].focus = focus;
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

  jumpTo() {
    widget.controller.jumpTo(0);
  }
}
