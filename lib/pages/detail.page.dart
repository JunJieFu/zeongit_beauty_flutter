import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  dynamic _loading = true;
  PictureEntity _picture;

  Future<void> _get() async {
    var result = await PictureService.get(widget.id);
    setState(() {
      _picture = result.data;
      _loading = false;
    });
    return;
  }

  @override
  void initState() {
    super.initState();
    _get();
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return _picture != null  ? Scaffold(
            body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                elevation: 1,
                //默认高度是状态栏和导航栏的高度，如果有滚动视差的话，要大于前两者的高度
                floating: false,
                expandedHeight:
                    queryData.size.width * _picture.height / _picture.width,
                //只跟floating相对应，如果为true，floating必须为true，也就是向下滑动一点儿，整个大背景就会动画显示全部，网上滑动整个导航栏的内容就会消失
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                      child: Image.network(
                          "http://secdraimg.secdra.com/" +
                              _picture.url +
                              "-specifiedWidth1200",
                          fit: BoxFit.cover)),
                  centerTitle: true,
                  collapseMode: CollapseMode.pin,
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate(
                //返回组件集合
                  [
                    Container(
                        child: Image.network(
                            "http://secdraimg.secdra.com/" +
                                _picture.url +
                                "-specifiedWidth1200",
                            fit: BoxFit.cover))
                  ]
                ),
              )
            ],
          ))
        : Scaffold(body: Container());
  }
}
