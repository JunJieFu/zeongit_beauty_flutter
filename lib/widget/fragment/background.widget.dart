import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeongitbeautyflutter/assets/constant/config.constant.dart';

enum BackgroundStyle { backCard }

class BackgroundWidget extends StatelessWidget {
  BackgroundWidget(this.url, {Key key, this.fit, this.style}) : super(key: key);

  final String url;

  final BoxFit fit;

  final BackgroundStyle style;

  @override
  Widget build(BuildContext context) {
    var _url = style != null
        ? "${ConfigConstant.QINIU_BACKGROUND}/${url}${ConfigConstant.QINIU_SEPARATOR}${style.toString().split('.').last}"
        : "${ConfigConstant.QINIU_BACKGROUND}/${url}";
    return CachedNetworkImage(
        imageUrl: _url,
        fit: fit,
        errorWidget: (BuildContext context, String url, dynamic error) {
          return SvgPicture.asset("assets/images/default-picture.svg",
              fit: fit);
        });
  }
}
