import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeongitbeautyflutter/assets/constant/config.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/style/index.style.dart';
import 'package:zeongitbeautyflutter/assets/util/string.util.dart';

enum AvatarStyle { small50, small100, small200 }

const avatarColorList = [
  StyleConfig.accentColor,
  StyleConfig.errorColor,
  StyleConfig.infoColor,
  StyleConfig.successColor,
  StyleConfig.warningColor
];

class AvatarWidget extends StatelessWidget {
  AvatarWidget(this.info, {Key key, this.size = 50.0, this.fit, this.style})
      : super(key: key);

  final UserInfoEntity info;

  final BoxFit fit;

  final AvatarStyle style;

  final double size;

  @override
  Widget build(BuildContext context) {
    Widget build = buildSvgPicture();
    final IconThemeData iconTheme = IconTheme.of(context);
    print(iconTheme.size);
    if (info != null) {
      if (info.avatarUrl != null) {
        build = buildCachedNetworkImage();
      } else {
        build = buildNicknameAvatar();
      }
    }

    return SizedBox(
        width: size,
        child: AspectRatio(
            aspectRatio: 1,
            child: ClipOval(
              child: build,
            )));
  }

  CachedNetworkImage buildCachedNetworkImage() {
    Widget errorWidget = buildSvgPicture();
    String url;
    if (info != null) {
      errorWidget = buildNicknameAvatar();
      url = style != null
          ? "${ConfigConstant.QINIU_AVATAR}/${info.avatarUrl}${ConfigConstant.QINIU_SEPARATOR}${StringUtil.enumToString(style)}"
          : "${ConfigConstant.QINIU_AVATAR}/${info.avatarUrl}";
    }
    return CachedNetworkImage(
        imageUrl: url,
        fit: fit,
        errorWidget: (BuildContext context, String url, dynamic error) {
          return errorWidget;
        });
  }

  SvgPicture buildSvgPicture() =>
      SvgPicture.asset("assets/images/default-avatar.svg", fit: fit);

  Widget buildNicknameAvatar() {
    var character = info?.nickname?.substring(0, 1) ?? "";
    var index = (info?.nickname?.codeUnitAt(0) ?? 2) % avatarColorList.length;
    return Container(
      color: avatarColorList[index],
      child: Center(
        child: Text(
          character,
          style: TextStyle(color: Colors.white, fontSize: size * .5),
        ),
      ),
    );
  }
}
