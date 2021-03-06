import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeongitbeautyflutter/plugins/constants/config.constant.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/string.util.dart';

enum AvatarStyle { small50, small100, small200 }

const avatarColorList = [
  StyleConfig.accentColor,
  StyleConfig.errorColor,
  StyleConfig.infoColor,
  StyleConfig.successColor,
  StyleConfig.warningColor
];

class AvatarWidget extends StatelessWidget {
  AvatarWidget(this.url, this.nickname,
      {Key? key, this.size = 50.0, this.fit = BoxFit.contain, this.style})
      : super(key: key);

  final String? url;

  final String nickname;

  final BoxFit fit;

  final AvatarStyle? style;

  final double size;

  @override
  Widget build(BuildContext context) {
    Widget build = _buildSvgPicture();
    if (url != null) {
      build = _buildCachedNetworkImage();
    } else {
      build = _buildNicknameAvatar();
    }

    return SizedBox(
        width: size,
        child: AspectRatio(
            aspectRatio: 1,
            child: ClipOval(
              child: build,
            )));
  }

  CachedNetworkImage _buildCachedNetworkImage() {
    Widget errorWidget = _buildSvgPicture();
    String _url;
    errorWidget = _buildNicknameAvatar();
    _url = style != null
        ? "${ConfigConstant.QINIU_AVATAR}/$url${ConfigConstant.QINIU_SEPARATOR}${StringUtil.enumToString(style)}"
        : "${ConfigConstant.QINIU_AVATAR}/$url";
    return CachedNetworkImage(
        imageUrl: _url,
        fit: fit,
        errorWidget: (BuildContext context, String url, dynamic error) {
          return errorWidget;
        });
  }

  SvgPicture _buildSvgPicture() =>
      SvgPicture.asset("assets/images/default-avatar.svg", fit: fit);

  Widget _buildNicknameAvatar() {
    var character = nickname.substring(0, 1);
    var index = (nickname.codeUnitAt(0)) % avatarColorList.length;
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
