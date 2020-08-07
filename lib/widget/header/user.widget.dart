import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widget/fragment/avatar.widget.dart';

import '../popup.fun.dart';

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
        popupSignIn("想要成为Zeongit用户？", "请先登录，才能查看自己的主页。", context, _btnKey);
      },
    );
  }
}
