import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeongitbeautyflutter/assets/constant/config.constant.dart';

enum PictureStyle {
  specifiedWidth,
  specifiedWidth300,
  specifiedWidth500,
  specifiedWidth1200,
  specifiedHeight1200
}

class PictureWidget extends StatelessWidget {
  PictureWidget(this.url, {Key key, this.fit, this.pictureStyle})
      : super(key: key);

  final String url;

  final BoxFit fit;

  final PictureStyle pictureStyle;

  @override
  Widget build(BuildContext context) {
    var errorBuilder =
        (BuildContext context, Object error, StackTrace stackTrace) {
      return SvgPicture.asset("assets/images/default-avatar.svg", fit: fit);
    };

    if (pictureStyle != null) {
      return Image.network(
          "${ConfigConstant.qiniuPicture}/$url${ConfigConstant.qiniuSeparator}${pictureStyle.toString().split('.').last}",
          fit: fit,
          errorBuilder: errorBuilder);
    } else {
      return Image.network(
        ConfigConstant.qiniuPicture + '/' + url,
        fit: fit,
      );
    }
  }
}
