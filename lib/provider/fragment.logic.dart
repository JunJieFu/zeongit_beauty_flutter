import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/pages/home/tab.page.dart';
import 'package:zeongitbeautyflutter/pages/search/search_tab.page.dart';
import 'package:zeongitbeautyflutter/plugins/constants/key.constant.dart';
import 'package:zeongitbeautyflutter/plugins/utils/storage.util.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/comfir.widget.dart';

class FragmentLogic extends GetxController {
  final _hasInit = (StorageManager.getBool(KeyConstant.HAD_INIT) ?? false).obs;

  bool get hasInit => _hasInit.value;

  final _searchHistory =
      (StorageManager.getStringList(KeyConstant.SEARCH_HISTORY) ?? <String>[])
          .obs;

  RxList<String> get searchHistory => _searchHistory;

  updateHadInit() {
    StorageManager.setBool(KeyConstant.HAD_INIT, true);
    Get.off(TabPage());
  }

  searchPicture(String tagListString, {bool off = false}) {
    if (tagListString != null && tagListString != "") {
      var tagList = tagListString.split(" ");
      tagList.forEach((tag) {
        _searchHistory.removeWhere((element) => tag == element);
      });
      _searchHistory.insertAll(0, tagList);
      if (_searchHistory.length > 10) {
        _searchHistory.removeRange(10, _searchHistory.length);
      }
      StorageManager.setStringList(KeyConstant.SEARCH_HISTORY, _searchHistory);
    }
    if (off) {
      Get.off(() => SearchTabPage(
            keyword: tagListString,
          ));
    } else {
      Get.to(() => SearchTabPage(
            keyword: tagListString,
          ));
    }
  }

  removeHistory() {
    showDialog(
        context: Get.context!,
        builder: (ctx) {
          return Confirm(
            title: Text("提示"),
            content: Text("您确定清空搜索历史吗？"),
            cancelText: Text("取消"),
            confirmText: Text("确定"),
            confirmCallback: () async {
              Get.back();
              _searchHistory.removeRange(0, _searchHistory.length);
              StorageManager.setStringList(
                  KeyConstant.SEARCH_HISTORY, _searchHistory);
            },
          );
        });
  }
}
