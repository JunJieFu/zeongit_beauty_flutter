import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';

abstract class RefreshAbstract<T extends StatefulWidget> extends State<T> {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  ScrollController scrollController;

  externalRefresh() {
    scrollController?.animateTo(0,
        duration: Duration(milliseconds: StyleConfig.durationMilliseconds),
        curve: Curves.ease);
    refreshIndicatorKey.currentState?.show();
  }
}
