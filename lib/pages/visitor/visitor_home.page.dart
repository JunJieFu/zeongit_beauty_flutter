import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor.provider.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/avatar.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/background.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/text.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/title.widget.dart';
import 'package:zeongitbeautyflutter/widget/btn/follow_icon_btn.widget.dart';
import 'package:zeongitbeautyflutter/widget/btn/share_user_icon_btn.dart';

class VisitorHomePage extends StatefulWidget {
  VisitorHomePage({Key key}) : super(key: key);

  @override
  _VisitorHomePageState createState() => _VisitorHomePageState();
}

class _VisitorHomePageState extends State<VisitorHomePage>
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
    return Consumer<VisitorState>(
        builder: (ctx, VisitorState visitorState, child) {
      return ListView(
        children: [
          Stack(children: <Widget>[
            AspectRatio(
              aspectRatio: 2,
              child: BackgroundWidget(
                visitorState.info?.background,
                fit: BoxFit.cover,
                style: BackgroundStyle.backCard,
              ),
            ),
            Align(
              child: Padding(
                padding: EdgeInsets.only(top: StyleConfig.gap * 35),
                child: buildMaterialAvatar(visitorState),
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.only(top: StyleConfig.gap * 3),
            child: Center(child: TitleWidget(visitorState.info.nickname)),
          ),
          Padding(
            padding: EdgeInsets.only(top: StyleConfig.gap),
            child: Center(child: TextWidget(visitorState.info.introduction)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FollowIconBtn(
                  user: visitorState.info,
                  callback: (UserInfoEntity user, int focus) {
                    visitorState.focus(focus);
                  }),
              ShareUserIconBtn(
                user: visitorState.info,
                callback: () {},
              ),
            ],
          )
        ],
      );
    });
  }

  Material buildMaterialAvatar(VisitorState visitorState) {
    var size = 120.0;
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(size)),
      elevation: 3,
      child: AvatarWidget(
          visitorState.info?.avatarUrl, visitorState.info?.nickname,
          fit: BoxFit.cover, size: size),
    );
  }
}
