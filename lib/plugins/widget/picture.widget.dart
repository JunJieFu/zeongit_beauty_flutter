import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeongitbeautyflutter/plugins/constant/config.constant.dart';
import 'package:zeongitbeautyflutter/plugins/util/string.util.dart';

enum PictureStyle {
  specifiedWidth,
  specifiedWidth300,
  specifiedWidth500,
  specifiedWidth1200,
  specifiedHeight1200
}

class PictureWidget extends StatelessWidget {
  PictureWidget(this.url, {Key key, this.fit = BoxFit.contain, this.style})
      : super(key: key);

  final String url;

  final BoxFit fit;

  final PictureStyle style;

  @override
  Widget build(BuildContext context) {
    var _url = style != null
        ? "${ConfigConstant.QINIU_PICTURE}/$url${ConfigConstant.QINIU_SEPARATOR}${StringUtil.enumToString(style)}"
        : "${ConfigConstant.QINIU_PICTURE}/$url";
    return url != null
        ? CachedNetworkImage(
            imageUrl: _url,
            fit: fit,
            progressIndicatorBuilder:(BuildContext context, String url,DownloadProgress progress,){
               return Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            errorWidget: (BuildContext context, String url, dynamic error) {
              return buildSvgPicture();
            })
        : buildSvgPicture();
  }

  SvgPicture buildSvgPicture() =>
      SvgPicture.asset("assets/images/default-picture.svg", fit: fit);
}
