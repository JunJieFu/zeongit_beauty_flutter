import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeongitbeautyflutter/assets/constant/config.constant.dart';

enum AvatarStyle { small50, small100, small200 }

class AvatarWidget extends StatefulWidget {
  AvatarWidget(this.url, {Key key, this.fit, this.avatarStyle})
      : super(key: key);

  final String url;

  final BoxFit fit;

  final AvatarStyle avatarStyle;

  @override
  State<StatefulWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  @override
  Widget build(BuildContext context) {
    var _url = widget.avatarStyle != null
        ? "${ConfigConstant.qiniuAvatar}/${widget.url}${ConfigConstant.qiniuSeparator}${widget.avatarStyle.toString().split('.').last}"
        : "${ConfigConstant.qiniuAvatar}/${widget.url}";
    return Image.network(_url, fit: widget.fit, errorBuilder:
        (BuildContext context, Object error, StackTrace stackTrace) {
      return SvgPicture.asset("assets/images/default-avatar.svg",
          fit: widget.fit);
    });
  }
}
