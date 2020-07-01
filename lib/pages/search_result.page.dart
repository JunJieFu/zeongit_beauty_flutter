import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/search.page.dart';
import 'package:zeongitbeautyflutter/widget/fragment/list_waterfall.widget.dart';

class SearchResultPage extends StatefulWidget {
  SearchResultPage({Key key, @required this.keyword}) : super(key: key);

  final String keyword;

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  bool _loading = false;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey;
  PagePictureEntity _page;
  List<PictureEntity> _list = [];
  PageableEntity _pageable =
      PageableEntity(page: 0, size: 16, sort: "createDate,desc");

  Future<void> _refresh() async {
    _paging(0);
  }

  Future<void> _paging(int page) async {
    _pageable.page = page;
    if (this._loading || (this._page != null && this._page.last)) return;
    _loading = true;
    var result =
        await PictureService.paging(_pageable, tagList: widget.keyword);
    setState(() {
      _page = result.data;
      if (page == 0) {
        _list = _page.content;
      } else {
        _list.addAll(_page.content);
      }
    });
    _loading = false;
  }

  @override
  void initState() {
    super.initState();
    _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.keyword),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return SearchPage();
                }));
              },
            )
          ],
        ),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refresh,
            child: ListWaterFallWidget(
                page: _page, list: _list, paging: _paging)));
  }
}
