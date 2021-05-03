import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/tag_frequency_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';

class _Refresh extends Hook<RefreshHookResult> {
  _Refresh();

  @override
  _RefreshState createState() => _RefreshState();
}

class _RefreshState extends HookState<RefreshHookResult, _Refresh> {
  RefreshController refreshController = RefreshController(initialRefresh: true);

  @override
  build(BuildContext context) {
    var result = new RefreshHookResult();
    result.refreshController = refreshController;
    result.externalRefresh = externalRefresh;
    result.listTagTop30 = listTagTop30;
    result.recommendTagList = recommendTagList;
    return result;
  }

  externalRefresh() {
    refreshController.requestRefresh(
        duration: const Duration(milliseconds: 200));
  }

  Future<void> listTagTop30() async {
    var result = await TagService.listTagTop30();
    setState(() {
      recommendTagList = result.data;
    });
    refreshController.refreshCompleted();
    return;
  }

  List<TagFrequencyEntity> recommendTagList = [];
}

class RefreshHookResult {
  RefreshController refreshController;
  void Function() externalRefresh;
  Future<void> Function() listTagTop30;
  List<TagFrequencyEntity> recommendTagList;
}

RefreshHookResult useRefresh(BuildContext context) {
  return use(_Refresh());
}
