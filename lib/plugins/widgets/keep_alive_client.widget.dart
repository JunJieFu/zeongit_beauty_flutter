import 'package:flutter/cupertino.dart';

class KeepAliveClient extends StatefulWidget {
  KeepAliveClient({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  _KeepAliveClientState createState() => _KeepAliveClientState();
}

class _KeepAliveClientState extends State<KeepAliveClient>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
