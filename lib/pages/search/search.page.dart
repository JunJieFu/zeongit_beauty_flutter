import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/pages/search/search_tab.page.dart';
import 'package:zeongitbeautyflutter/provider/fragment.logic.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key key, this.keyword, this.index = 0}) : super(key: key);

  final String keyword;

  final int index;

  @override
  Widget build(BuildContext context) {
    return GetX<SearchLogic>(
        global: false,
        init: SearchLogic(keyword, index),
        builder: (logic) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              title: TextField(
                  autofocus: true,
                  controller: logic.keywordController,
                  decoration: InputDecoration(
                    hintText: "搜索",
                    border: InputBorder.none,
                  ),
                  onSubmitted: (text) {
                    logic.search();
                  }),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: logic.search,
                )
              ],
            ),
            body: ListView(
              children:
              logic.list?.map((e) =>
                  Column(children: [
                    ListTile(title: Text(e), onTap: () {
                      logic.tapSuggest(e);
                    },),
                    Divider(height: 1),
                  ],))?.toList() ??
                  [],
            ),
          );
        });
  }
}

class SearchLogic extends GetxController {
  SearchLogic(this.keyword, this.index)
      : keywordController = TextEditingController(text: keyword);

  final keywordController;

  final String keyword;

  final int index;

  final fragmentLogic = Get.find<FragmentLogic>();

  final list = RxList(<String>[]);

  search() {
    if (index == 0) {
      fragmentLogic.searchPicture(keywordController.text, off: true);
    } else {
      Get.off(SearchTabPage(
        keyword: keywordController.text,
        index: index,
      ));
    }
  }

  tapSuggest(String tag) {
    fragmentLogic.searchPicture(tag, off: true);
  }

  @override
  void onInit() {
    keywordController.addListener(() async {
      final result = await SuggestService.search(keywordController.text);
      list.value = result.data;
    });
    super.onInit();
  }

  @override
  void onClose() {
    keywordController.dispose();
    super.onClose();
  }
}
