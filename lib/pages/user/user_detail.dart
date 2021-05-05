import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/pages/user/user_module.provider.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/avatar.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/background.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/text.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/title.widget.dart';
import 'package:zeongitbeautyflutter/widgets/btn/follow_icon_btn.widget.dart';
import 'package:zeongitbeautyflutter/widgets/btn/share_user_icon_btn.dart';

class UserDetailPage extends StatefulWidget {
  UserDetailPage({Key key}) : super(key: key);

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<UserModuleState>(
        builder: (ctx, UserModuleState state, child) {
      return ListView(
        children: [
          Stack(children: <Widget>[
            AspectRatio(
              aspectRatio: 2,
              child: BackgroundWidget(
                state.info?.background,
                fit: BoxFit.cover,
                style: BackgroundStyle.backCard,
              ),
            ),
            Align(
              child: Padding(
                padding: EdgeInsets.only(top: StyleConfig.gap * 35),
                child: _buildMaterialAvatar(state),
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.only(top: StyleConfig.gap * 3),
            child: Center(child: TitleWidget(state.info.nickname)),
          ),
          Padding(
            padding: EdgeInsets.only(top: StyleConfig.gap),
            child: Center(child: TextWidget(state.info.introduction)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FollowIconBtn(
                  user: state.info,
                  callback: (UserInfoEntity user, int focus) {
                    state.focus(focus);
                  }),
              ShareUserIconBtn(
                user: state.info,
                callback: () {},
              ),
            ],
          )
        ],
      );
    });
  }

  _buildMaterialAvatar(UserModuleState state) {
    var size = 120.0;
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(size)),
      elevation: 3,
      child: AvatarWidget(state.info?.avatarUrl, state.info?.nickname,
          fit: BoxFit.cover, size: size),
    );
  }
}
