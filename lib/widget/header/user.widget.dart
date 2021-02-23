import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/plugins/widget/avatar.widget.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widget/popup.fun.dart';

class UserWidget extends StatelessWidget {
  UserWidget({Key key}) : super(key: key);
  final GlobalKey _btnKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var userState = Provider.of<UserState>(context, listen: false);

    return IconButton(
      key: _btnKey,
      icon: AvatarWidget(
        userState.info?.avatarUrl,
        userState.info?.nickname,
        size: 30,
        fit: BoxFit.cover,
        style: AvatarStyle.small50,
      ),
      onPressed: () {
        popupSignIn("想要成为Zeongit用户？", "请先登录，才能查看自己的主页。", context, _btnKey);
      },
    );
  }
}
