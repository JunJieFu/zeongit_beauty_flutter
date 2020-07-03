import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/assets/style/index.style.dart';
import 'package:zeongitbeautyflutter/widget/fragment/image_ink_clip.widget.dart';
import 'package:zeongitbeautyflutter/widget/fragment/link.widget.dart';
import 'package:zeongitbeautyflutter/widget/fragment/picture.widget.dart';
import 'package:zeongitbeautyflutter/widget/fragment/text.widget.dart';
import 'package:zeongitbeautyflutter/widget/fragment/title.widget.dart';

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
                  background: PictureWidget(_picture.url,
                      pictureStyle: PictureStyle.specifiedHeight1200,
                      fit: BoxFit.cover),
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
                          TitleWidget(_picture.name + _picture.name),
                          TextWidget("创建于${_picture.createDate}"),
                          Wrap(
                            children: <Widget>[
                              Wrap(children: <Widget>[
                                LinkWidget("${_picture.viewAmount}"),
                                TextWidget("人阅读")
                              ]),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: StyleConfig.gap * 3),
                                  child: Wrap(children: <Widget>[
                                    LinkWidget("${_picture.likeAmount}"),
                                    TextWidget("人喜欢")
                                  ])),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: pageGap),
                            child: TextWidget(_picture.introduction),
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
                        ImageInkClipWidget(
                          size: 75,
                          child: Image.network(
                              "http://secdraimg.secdra.com/" +
                                  _picture.url +
                                  "-specifiedWidth1200",
                              fit: BoxFit.cover),
                          onTap: () {},
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: StyleConfig.gap * 2),
                            child: Text(_picture.user.nickname),
                          ),
                        ),
                        RaisedButton(
                          highlightElevation: 0,
                          elevation: 0,
                          child: Text("关注"),
                          onPressed: () {},
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
