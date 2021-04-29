import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';

abstract class RefreshAbstract<T extends StatefulWidget> extends State<T> {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  ScrollController scrollController;

  externalRefresh();
}

mixin RefreshMixin<T extends StatefulWidget> on State<T>
    implements RefreshAbstract<T> {
  @override
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  ScrollController scrollController = ScrollController();

  @override
  externalRefresh() {
    scrollController?.animateTo(0,
        duration: Duration(milliseconds: StyleConfig.durationMilliseconds),
        curve: Curves.ease);
    refreshIndicatorKey.currentState?.show();
  }
}
