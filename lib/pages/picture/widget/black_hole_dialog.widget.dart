import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor_tab.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/avatar.widget.dart';
import 'package:zeongitbeautyflutter/widget/black_hole_avatar.widget.dart';

class BlackHoleDialogWidget extends StatefulWidget {
  BlackHoleDialogWidget({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  _BlackHoleDialogWidgetState createState() => _BlackHoleDialogWidgetState();
}

class _BlackHoleDialogWidgetState extends State<BlackHoleDialogWidget> {
  Future<BlackHoleEntity> data;

  Future<BlackHoleEntity> fetchData() async {
    await Future.delayed(Duration(milliseconds: 500));
    return (await PictureBlackHoleService.get(widget.id)).data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot<BlackHoleEntity> snapshot) {
        print(snapshot);
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var user = snapshot.data.user;
            var tagList = snapshot.data.tagList;
            return SimpleDialog(
              title: Text("屏蔽设置"),
              children: <Widget>[
                Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                    width: MediaQuery.of(context).size.width,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        buildAvatar(user),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: StyleConfig.gap * 2),
                            child: Text(user.nickname),
                          ),
                        ),
                      ],
                    )),
                Divider(),
                ...buildTagList(tagList),
              ],
            );
          } else {
            return buildLoading();
          }
        } else {
          return buildLoading();
        }
      },
    );
  }

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
        child: BlackHoleAvatarWidget(
          user,
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
              "加载中",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
