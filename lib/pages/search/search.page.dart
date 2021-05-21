import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/pages/search/search_tab.page.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/text_editing_controller.hook.dart';
import 'package:zeongitbeautyflutter/provider/fragment.logic.dart';

class SearchPage extends HookWidget {
  SearchPage({Key? key, this.keyword, this.index = 0})
      : _keyword = (keyword ?? "").obs,
        super(key: key);

  final String? keyword;

  final int index;

  final _fragmentLogic = Get.find<FragmentLogic>();

  final _throttle =
      Throttle<String?>(Duration(milliseconds: 200), initialValue: null);

  final Rx<String> _keyword;

  final _list = RxList(<String>[]);

  search() {
    if (index == 0) {
      _fragmentLogic.searchPicture(_keyword.value, off: true);
    } else {
      Get.off(SearchTabPage(
        keyword: _keyword.value,
        index: index,
      ));
    }
  }

  tapSuggest(String tag) {
    _fragmentLogic.searchPicture(tag, off: true);
  }

  @override
  Widget build(BuildContext context) {
    final keywordController = useTextEditingControllerObs(_keyword);

    useEffect(() {
      keywordController.addListener(() {
        _throttle.value = keywordController.text;
      });
      _throttle.values.listen((search) async {
        if (search == null || search == "") {
          _list.value = [];
        } else {
          final result = await SuggestService.search(search);
          _list.value = result.data!;
        }
      });
    }, []);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: TextField(
            autofocus: true,
            controller: keywordController,
            decoration: InputDecoration(
              hintText: "搜索",
              border: InputBorder.none,
            ),
            onSubmitted: (text) {
              search();
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: search,
          )
        ],
      ),
      body: Obx(
        () => ListView(
          children: _list
              .map((e) => Column(
                    children: [
                      ListTile(
                        title: Text(e),
                        onTap: () {
                          tapSuggest(e);
                        },
                      ),
                      Divider(height: 1),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
