import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DefaultRefreshConfiguration extends StatelessWidget {
  DefaultRefreshConfiguration({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
        headerBuilder: () => MaterialClassicHeader(
              color: Get.theme.primaryColor,
              backgroundColor: Get.theme.brightness == Brightness.dark
                  ? Get.theme.cardColor
                  : Colors.white,
            ),
        footerBuilder: () =>
            CustomFooter(builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("上拉加载");
              } else if (mode == LoadStatus.loading) {
                body = CircularProgressIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("加载失败，点击重试");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("松手加载更多");
              } else {
                body = Text("没有更多数据了");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            }),
        child: child);
  }
}
