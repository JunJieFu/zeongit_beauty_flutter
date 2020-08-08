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
  PictureWidget(this.url,
      {Key key, this.fit = BoxFit.contain, this.pictureStyle})
      : super(key: key);

  final String url;

  final BoxFit fit;

  final PictureStyle pictureStyle;

  @override
  Widget build(BuildContext context) {
    var _url = pictureStyle != null
        ? "${ConfigConstant.qiniuPicture}/$url${ConfigConstant.qiniuSeparator}${pictureStyle.toString().split('.').last}"
        : "${ConfigConstant.qiniuPicture}/$url";
    return Image.network(_url, fit: fit
        , errorBuilder:
        (BuildContext context, Object error, StackTrace stackTrace) {
      return SvgPicture.asset("assets/images/default-picture.svg",
          fit: fit);
    }
    );
  }
}
