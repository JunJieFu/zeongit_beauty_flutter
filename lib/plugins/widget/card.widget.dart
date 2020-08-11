import 'package:flutter/cupertino.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';

class CardTitleWidget extends StatelessWidget {
  CardTitleWidget({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(StyleConfig.gap * 3),
      child: child,
    );
  }
}

class CardTextWidget extends StatelessWidget {
  CardTextWidget({
    Key key,
    this.child
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: StyleConfig.gap * 3,
          bottom: StyleConfig.gap * 3,
          right: StyleConfig.gap * 3),
      child: child,
    );
  }
}
