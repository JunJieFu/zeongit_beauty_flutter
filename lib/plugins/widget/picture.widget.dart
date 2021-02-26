import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:zeongitbeautyflutter/plugins/constant/config.constant.dart';
import 'package:zeongitbeautyflutter/plugins/util/permission.util.dart';
import 'package:zeongitbeautyflutter/plugins/util/string.util.dart';

import '../style/index.style.dart';

enum PictureStyle {
  specifiedWidth,
  specifiedWidth300,
  specifiedWidth500,
  specifiedWidth1200,
  specifiedHeight1200
}

class PictureWidget extends StatefulWidget {
  PictureWidget(this.url, {Key key, this.fit = BoxFit.contain, this.style})
      : super(key: key);

  final String url;

  final BoxFit fit;

  final PictureStyle style;

  @override
  PictureWidgetState createState() => PictureWidgetState();
}

class PictureWidgetState extends State<PictureWidget> {
  String completeUrl;

  @override
  Widget build(BuildContext context) {
    if (widget.url != null) {
      completeUrl = widget.style != null
          ? "${ConfigConstant.QINIU_PICTURE}/${widget.url}${ConfigConstant.QINIU_SEPARATOR}${StringUtil.enumToString(widget.style)}"
          : "${ConfigConstant.QINIU_PICTURE}/${widget.url}";
      return  CachedNetworkImage(
          imageUrl: completeUrl,
          fit: widget.fit,
          progressIndicatorBuilder:
              (BuildContext context, String url, DownloadProgress progress) {
            return Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            );
          },
          errorWidget: (BuildContext context, String url, dynamic error) {
            return buildSvgPicture();
          });
    } else {
      return buildSvgPicture();
    }
  }

  SvgPicture buildSvgPicture() =>
      SvgPicture.asset("assets/images/default-picture.svg", fit: widget.fit);

  saveStorage() async {
    if (await PermissionUtil.storage()) {
      final success = await GallerySaver.saveImage(completeUrl);
      if (success) {
        Fluttertoast.showToast(msg: "保存成功", gravity: ToastGravity.BOTTOM);
      } else {
        Fluttertoast.showToast(
            msg: "保存失败",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: StyleConfig.errorColor);
      }
    } else {
      Fluttertoast.showToast(
          msg: "保存失败",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: StyleConfig.errorColor);
    }
  }
}
