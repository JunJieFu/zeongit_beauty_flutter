import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/assets/style/index.style.dart';
import 'package:zeongitbeautyflutter/assets/util/image.util.dart';
import 'package:zeongitbeautyflutter/widget/fragment/ink_clip.widget.dart';

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
    var pageGap = StyleConfig.gap * 3;
    return _picture != null
        ? Scaffold(
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
                delegate: SliverChildListDelegate([
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.comment),
                      ),
                      IconButton(
                        icon: Icon(Icons.star_border),
                      ),
                      IconButton(
                        icon: Icon(Icons.share),
                      ),
                      IconButton(
                        icon: Icon(Icons.more_vert),
                      )
                    ],
                  ),
                  Divider(),
                  Padding(
                      padding: EdgeInsets.all(pageGap),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_picture.name + _picture.name,
                              textScaleFactor: 1.5),
                          Text(
                            "创建于${_picture.createDate}",
                            style: TextStyle(color: Colors.black54),
                          ),
                          Wrap(
                            children: <Widget>[
                              Wrap(children: <Widget>[
                                Text("1"),
                                Text(
                                  "123",
                                  style: TextStyle(color: Colors.black54),
                                )
                              ]),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: StyleConfig.gap * 3),
                                  child: Wrap(children: <Widget>[
                                    Text("1"),
                                    Text(
                                      "123",
                                      style: TextStyle(color: Colors.black54),
                                    )
                                  ])),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: pageGap),
                            child: Text(
                              _picture.introduction,
                              style: TextStyle(color: Colors.black54),
                            ),
                          )
                        ],
                      )),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: pageGap),
                    child: Wrap(
                        spacing: pageGap / 2,
                        runSpacing: -pageGap / 2,
                        children: _picture.tagList
                                ?.map((e) => ActionChip(
                                    label: Text(e),
                                    onPressed: () {
                                      print(e);
                                    }))
                                ?.toList() ??
                            <Widget>[]),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(pageGap),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        InkClipWidget(
                            child: SvgPicture.asset(
                                'assets/images/default-head.svg')),
                        Expanded(
                          flex: 1,
                          child: Text(_picture.user.nickname),
                        ),
                        RaisedButton(
                          highlightElevation: 0,
                          elevation: 0,
                          child: Text("关注"),
                          onPressed: (){},
                        )
                      ],
                    ),
                  ),
                ]),
              )
            ],
          ))
        : Scaffold(body: Container());
  }
}
