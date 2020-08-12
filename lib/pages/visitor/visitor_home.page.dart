import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor.provider.dart';

class VisitorHomePage extends StatefulWidget {
  VisitorHomePage({Key key}) : super(key: key);

  @override
  _VisitorHomePageState createState() => _VisitorHomePageState();
}

class _VisitorHomePageState extends State<VisitorHomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<VisitorState>(
        builder: (ctx, VisitorState visitorState, child) {
      return Text(visitorState.info.nickname);
    });
  }
}
