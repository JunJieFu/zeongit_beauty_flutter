import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeongitbeautyflutter/assets/constant/config.constant.dart';

enum AvatarStyle { small50, small100, small200 }

class AvatarWidget extends StatelessWidget {
  AvatarWidget(this.url, {Key key, this.fit, this.avatarStyle})
      : super(key: key);

  final String url;

  final BoxFit fit;

  final AvatarStyle avatarStyle;

  @override
  Widget build(BuildContext context) {
    var _url = avatarStyle != null
        ? "${ConfigConstant.QINIU_AVATAR}/${url}${ConfigConstant.QINIU_SEPARATOR}${avatarStyle.toString().split('.').last}"
        : "${ConfigConstant.QINIU_AVATAR}/${url}";
    return CachedNetworkImage(
        imageUrl: _url,
        fit: fit,
        errorWidget: (BuildContext context, String url, dynamic error) {
          return SvgPicture.asset("assets/images/default-avatar.svg", fit: fit);
        });
  }
}
