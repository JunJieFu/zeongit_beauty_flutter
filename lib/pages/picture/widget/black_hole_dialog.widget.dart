import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/abstract/future_builder_abstract.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor_tab.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/avatar.widget.dart';
import 'package:zeongitbeautyflutter/widget/btn/block_tag_icon_btn.widget.dart';
import 'package:zeongitbeautyflutter/widget/btn/block_user_icon_btn.widget.dart';

class BlackHoleDialogWidget extends StatefulWidget {
  BlackHoleDialogWidget({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  _BlackHoleDialogWidgetState createState() => _BlackHoleDialogWidgetState();
}

class _BlackHoleDialogWidgetState
    extends FutureBuildAbstract<BlackHoleDialogWidget, BlackHoleEntity> {
  @override
  Future<ResultEntity<BlackHoleEntity>> fetchData() async {
    return await PictureBlackHoleService.get(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return futureBuilder();
  }

  AlertDialog buildLoading() {
    return AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
            ),
            child: Text(
              "加载中...",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildError(BuildContext context) => buildLoading();

  @override
  Widget buildMain(BuildContext context, ResultEntity<BlackHoleEntity> result) {
    return _View(blackHole: source);
  }

  @override
  Widget buildSkeleton(BuildContext context) => buildLoading();
}

class _View extends StatefulWidget {
  _View({Key key, @required this.blackHole}) : super(key: key);

  final BlackHoleEntity blackHole;

  @override
  _ViewState createState() => _ViewState(blackHole);
}

class _ViewState extends State<_View> {
  _ViewState(this.blackHole);

  BlackHoleEntity blackHole;

  List<Padding> buildTagList(List<TagBlackHoleEntity> tagList) {
    return tagList
        .map((e) => Padding(
              padding: EdgeInsets.all(StyleConfig.gap * 3),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                      child: Text(e.name),
                    ),
                  ),
                  BlockTagIconBtnWidget(
                      tag: e,
                      callback: (TagBlackHoleEntity tag, int state) {
                        setState(() {
                          tag.state = state;
                        });
                      })
                ],
              ),
            ))
        .toList();
  }

  InkWell buildAvatar(UserBlackHoleEntity user) {
    var size = 75.0;
    var padding = 8.0;
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(size / 2)),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: AvatarWidget(
          user?.avatarUrl,
          user?.nickname,
          size: size - padding * 2,
          fit: BoxFit.cover,
          style: AvatarStyle.small50,
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return VisitorTabPage(id: user.id);
        }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var user = blackHole.user;
    var tagList = blackHole.tagList;
    return SimpleDialog(
      title: Text("屏蔽设置"),
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
            width: MediaQuery.of(context).size.width,
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                buildAvatar(user),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                    child: Text(user.nickname),
                  ),
                ),
                BlockUserIconBtnWidget(
                    user: user,
                    callback: (UserBlackHoleEntity result, int state) {
                      setState(() {
                        result.state = state;
                      });
                    })
              ],
            )),
        Divider(),
        ...buildTagList(tagList),
      ],
    );
  }
}
