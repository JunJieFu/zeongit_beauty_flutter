import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor_tab.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/widget/btn/follow_btn.widget.dart';

import 'avatar.widget.dart';

class ListUserWidget extends StatefulWidget {
  ListUserWidget({Key key, this.page, this.list, this.paging})
      : super(key: key);

  final PageUserInfoEntity page;

  final List<UserInfoEntity> list;

  final paging;

  @override
  _ListUserWidgetState createState() => _ListUserWidgetState();
}

class _ListUserWidgetState extends State<ListUserWidget> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent -
              _scrollController.position.pixels <
          150) {
        if (widget.paging != null) {
          widget.paging(widget.page.pageable.pageNumber + 2);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
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
                    buildAvatar(user),
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
                      callback: (user, String focus) {
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

  InkWell buildAvatar(UserInfoEntity user) {
    var size = 75.0;
    var padding = 8.0;
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(size / 2)),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: AvatarWidget(
          user,
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
