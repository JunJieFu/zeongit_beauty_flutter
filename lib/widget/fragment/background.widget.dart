import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeongitbeautyflutter/assets/constant/config.constant.dart';

enum BackgroundStyle { backCard }

class BackgroundWidget extends StatefulWidget {
  BackgroundWidget(this.url, {Key key, this.fit, this.style})
      : super(key: key);

  final String url;

  final BoxFit fit;

  final BackgroundStyle style;

  @override
  State<StatefulWidget> createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> {
  @override
  Widget build(BuildContext context) {
    var _url = widget.style != null
        ? "${ConfigConstant.qiniuBackground}/${widget.url}${ConfigConstant.qiniuSeparator}${widget.style.toString().split('.').last}"
        : "${ConfigConstant.qiniuBackground}/${widget.url}";
    return Image.network(_url, fit: widget.fit, errorBuilder:
        (BuildContext context, Object error, StackTrace stackTrace) {
      return SvgPicture.asset("assets/images/default-picture.svg",
          fit: widget.fit);
    });
  }
}
