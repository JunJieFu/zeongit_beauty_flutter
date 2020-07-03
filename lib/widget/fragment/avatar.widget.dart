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
    var errorBuilder =
        (BuildContext context, Object error, StackTrace stackTrace) {
      return SvgPicture.asset("assets/images/default-avatar.svg", fit: fit);
    };

    if (avatarStyle != null) {
      return Image.network(
          "${ConfigConstant.qiniuAvatar}/$url${ConfigConstant.qiniuSeparator}${avatarStyle.toString().split('.').last}",
          fit: fit,
          errorBuilder: errorBuilder);
    } else {
      return Image.network(
        ConfigConstant.qiniuAvatar + '/' + url,
        fit: fit,
      );
    }
  }
}
