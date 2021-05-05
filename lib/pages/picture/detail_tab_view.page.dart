import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zeongitbeautyflutter/pages/picture/detail.page.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';

class DetailTabViewPage extends HookWidget {
  DetailTabViewPage({Key key, @required this.list, @required this.index})
      : super(key: key);

  final List<int> list;
  final int index;

  @override
  Widget build(BuildContext context) {
    var tabController =
        useTabController(initialLength: list.length, initialIndex: index);

    return TabBarView(
      controller: tabController,
      children: this
          .list
          .map((id) => KeepAliveClient(child: DetailPage(id: id)))
          .toList(),
    );
  }
}
