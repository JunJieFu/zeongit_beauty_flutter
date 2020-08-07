import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/style/index.style.dart';
import 'package:zeongitbeautyflutter/pages/sign_in.page.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widget/fragment/avatar.widget.dart';
import 'package:zeongitbeautyflutter/widget/fragment/popup_container.widget.dart';
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
          PopupContainerRoute(
            child: PopupContainer(
              targetRenderKey: _btnKey,
              child: Card(
                child: Container(
                  width: 250,
                  padding: EdgeInsets.all(StyleConfig.gap * 3),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TitleWidget("想要成为ZeonGit用户？"),
                      TextWidget("请先登录，才能查看自己的主页。"),
                      Padding(
                        padding: EdgeInsets.only(top: StyleConfig.gap),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: OutlineButton(
                              child: Text("登录"),
                              borderSide: BorderSide(
                                color: StyleConfig.primaryColor,
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) {
                                  return SignInPage();
                                }));
                              }),
                        ),
                      ),
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
