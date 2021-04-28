import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeongitbeautyflutter/plugins/constant/config.constant.dart';
import 'package:zeongitbeautyflutter/plugins/util/string.util.dart';

enum BackgroundStyle { backCard }

class BackgroundWidget extends StatelessWidget {
  BackgroundWidget(this.url, {Key key, this.fit, this.style}) : super(key: key);

  final String url;

  final BoxFit fit;

  final BackgroundStyle style;

  @override
  Widget build(BuildContext context) {
    var _url = style != null
        ? "${ConfigConstant.QINIU_BACKGROUND}/$url${ConfigConstant.QINIU_SEPARATOR}${StringUtil.enumToString(style)}"
        : "${ConfigConstant.QINIU_BACKGROUND}/$url";
    return url != null
        ? CachedNetworkImage(
        imageUrl: _url,
        fit: fit,
        progressIndicatorBuilder: (
            BuildContext context,
            String url,
            DownloadProgress progress,
            ) {
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
        },
        errorWidget: (BuildContext context, String url, dynamic error) {
          return _buildSvgPicture();
        })
        : _buildSvgPicture();
  }

  SvgPicture _buildSvgPicture() =>
      SvgPicture.asset("assets/images/default-picture.svg", fit: fit);
}
