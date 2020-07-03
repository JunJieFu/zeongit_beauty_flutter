import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widget/fragment/avatar.widget.dart';

class UserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _userState = Provider.of<UserState>(context, listen: false);

    return IconButton(
      icon: AspectRatio(
          aspectRatio: 1,
          child: ClipOval(
              child: AvatarWidget(
            _userState.info?.avatarUrl,
            fit: BoxFit.cover,
            avatarStyle: AvatarStyle.small50,
          ))),
      onPressed: () {},
    );
  }
}
