import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'file:///D:/project/flutter/zeongit_beauty_flutter/lib/plugins/widget/avatar.widget.dart';

import '../popup.fun.dart';

class UserWidget extends StatelessWidget {
  UserWidget({Key key}) : super(key: key);
  final GlobalKey _btnKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var _userState = Provider.of<UserState>(context, listen: false);

    return IconButton(
      key: _btnKey,
      icon: AvatarWidget(
        _userState.info,
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
