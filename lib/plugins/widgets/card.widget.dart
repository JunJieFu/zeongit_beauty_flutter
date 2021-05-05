import 'package:flutter/cupertino.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';

class CardTitle extends StatelessWidget {
  CardTitle({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(StyleConfig.gap * 3),
      child: child,
    );
  }
}

class CardText extends StatelessWidget {
  CardText({
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
