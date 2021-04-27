import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/search/search_result.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/provider/tag.provider.dart';

class TagPage extends StatefulWidget {
  TagPage({Key key}) : super(key: key);

  @override
  TagPageState createState() => TagPageState();
}

class TagPageState extends State<TagPage> {
  TagState tagState;
  bool loading = true;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  TextEditingController keywordController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  Future<void> _listTagTop30() async {
    var result = await TagService.listTagTop30();
    tagState.setRecommendTagList(result.data);
    setState(() {
      loading = false;
    });
    return;
  }

  _search() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return SearchResultPage(keyword: keywordController.text);
    }));
  }

  @override
  void initState() {
    super.initState();
    refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (tagState.recommendTagList == null) {
        refreshIndicatorKey.currentState?.show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    tagState = Provider.of<TagState>(context, listen: false);
    return Scaffold(
        body: RefreshIndicator(
          key: refreshIndicatorKey,
          onRefresh: _listTagTop30,
          child: ListView(
            controller: _scrollController,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(StyleConfig.gap * 2),
                child: Wrap(
                    spacing: StyleConfig.gap * 2,
                    runSpacing: -StyleConfig.gap,
                    children: tagState.recommendTagList
                        ?.map((e) => ActionChip(
                        label: Text(e.name),
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                                return SearchResultPage(keyword: e.name);
                              }));
                        }))
                        ?.toList() ??
                        <Widget>[]),
              )
            ],
          ),
        ));
  }

  parentTabTap() {
    _scrollController?.animateTo(0,
        duration: Duration(milliseconds: StyleConfig.durationMilliseconds),
        curve: Curves.ease);
    refreshIndicatorKey.currentState?.show();
  }

  @override
  void dispose() {
    super.dispose();
    keywordController.dispose();
  }
}
