import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widget/fragment/background.widget.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

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
        return Column(
          children: [
            AspectRatio(
              aspectRatio: 2,
              child: BackgroundWidget(
                userState.info?.background,
                fit: BoxFit.cover,
                style: BackgroundStyle.backCard,
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
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
