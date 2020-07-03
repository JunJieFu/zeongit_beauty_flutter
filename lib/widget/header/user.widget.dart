import 'package:flutter/material.dart';
import 'package:kumi_popup_window/PopRoute.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/style/index.style.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widget/fragment/avatar.widget.dart';
import 'package:zeongitbeautyflutter/widget/fragment/popup_window.widget.dart';
import 'package:zeongitbeautyflutter/widget/fragment/text.widget.dart';
import 'package:zeongitbeautyflutter/widget/fragment/title.widget.dart';

class UserWidget extends StatelessWidget {
  final GlobalKey _btnKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var _userState = Provider.of<UserState>(context, listen: false);

    return IconButton(
      key: _btnKey,
      icon: AspectRatio(
          aspectRatio: 1,
          child: ClipOval(
              child: AvatarWidget(
            _userState.info?.avatarUrl,
            fit: BoxFit.cover,
            avatarStyle: AvatarStyle.small50,
          ))),
      onPressed: () {
        Navigator.push(
          context,
          PopRoute(
            child: PopupWindow(
              targetRenderBox:
                  (_btnKey.currentContext.findRenderObject() as RenderBox),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(StyleConfig.gap * 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TitleWidget("想要成为ZeonGit用户？"),
                      TextWidget("请先登录，才能查看自己的主页。")
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
