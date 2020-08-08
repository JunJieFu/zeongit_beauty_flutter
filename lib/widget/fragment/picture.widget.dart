import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeongitbeautyflutter/assets/constant/config.constant.dart';
import 'package:zeongitbeautyflutter/assets/util/string.util.dart';

enum PictureStyle {
  specifiedWidth,
  specifiedWidth300,
  specifiedWidth500,
  specifiedWidth1200,
  specifiedHeight1200
}

class PictureWidget extends StatelessWidget {
  PictureWidget(this.url,
      {Key key, this.fit = BoxFit.contain, this.style})
      : super(key: key);

  final String url;

  final BoxFit fit;

  final PictureStyle style;

  @override
  Widget build(BuildContext context) {
    var _url = style != null
        ? "${ConfigConstant.QINIU_PICTURE}/$url${ConfigConstant.QINIU_SEPARATOR}${StringUtil.enumToString(style)}"
        : "${ConfigConstant.QINIU_PICTURE}/$url";
    return Image.network(_url, fit: fit
        , errorBuilder:
        (BuildContext context, Object error, StackTrace stackTrace) {
      return SvgPicture.asset("assets/images/default-picture.svg",
          fit: fit);
    }
    );
  }
}
