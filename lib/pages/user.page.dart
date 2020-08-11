import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/pages/works.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/background.widget.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widget/btn/follow_icon_btn.widget.dart';
import 'package:zeongitbeautyflutter/widget/btn/share_user_icon_btn.dart';
import 'file:///D:/project/flutter/zeongit_beauty_flutter/lib/plugins/widget/avatar.widget.dart';

import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

import 'collection.page.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<UserState>(builder: (ctx, UserState userState, child) {
      if (userState.info == null) {
        return _Unlisted();
      } else {
        return ListView(
          children: [
            Stack(children: <Widget>[
              AspectRatio(
                aspectRatio: 2,
                child: BackgroundWidget(
                  userState.info?.background,
                  fit: BoxFit.cover,
                  style: BackgroundStyle.backCard,
                ),
              ),
              Align(
                child: Padding(
                  padding: EdgeInsets.only(top: StyleConfig.gap * 30),
                  child: AvatarWidget(
                    userState.info,
                    fit: BoxFit.cover,
                    size: 150
                  ),
                ),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FollowIconBtn(
                  user: userState.info,
                  callback: () {},
                ),
                ShareUserIconBtn(
                  user: userState.info,
                  callback: () {},
                )
              ],
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return CollectionPage();
                }));
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return WorksPage();
                }));
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                userState.logout();
              },
            )
          ],
        );
      }
    });
  }
}

class _Unlisted extends StatelessWidget {
  _Unlisted({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInPageCardWidget(
        icon: MdiIcons.account_outline,
        title: "您的Zeongit Beauty主页",
        text: "请先登录，才能进入您的Zeongit Beauty主页。");
  }
}
