import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_black_hole_entity.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor_tab.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/avatar.widget.dart';
import 'package:zeongitbeautyflutter/widget/btn/block_user_icon_btn.widget.dart';

class ListUserWidget extends StatefulWidget {
  ListUserWidget(
      {Key key, this.currPage, this.list, this.controller, this.changePage})
      : super(key: key) {
    if (controller == null) this.controller = ScrollController();
  }

  final PageUserBlackHoleEntity currPage;

  final List<UserBlackHoleEntity> list;

  ScrollController controller;

  final Future<void> Function(int) changePage;

  @override
  _ListUserWidgetState createState() => _ListUserWidgetState();
}

class _ListUserWidgetState extends State<ListUserWidget> {

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
        itemCount: widget.list?.length,
        itemBuilder: (BuildContext context, int index) {
          UserBlackHoleEntity user = widget.list[index];
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
                    BlockUserIconBtnWidget(
                      user: user,
                      callback: (user, int state) {
                        setState(() {
                          widget.list[index].state = state;
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

  InkWell _buildAvatar(UserBlackHoleEntity user) {
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
