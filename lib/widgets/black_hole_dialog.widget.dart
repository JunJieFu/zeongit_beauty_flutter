import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/pages/user/user_tab.page.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/avatar.widget.dart';
import 'package:zeongitbeautyflutter/widgets/btn/block_tag_icon_btn.widget.dart';
import 'package:zeongitbeautyflutter/widgets/btn/block_user_icon_btn.widget.dart';

class BlackHoleDialog extends HookWidget {
  BlackHoleDialog({Key? key, required this.id}) : super(key: key);

  final int id;

  _buildLoading() {
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

  _buildMain(ResultEntity<BlackHoleEntity> result) {
    return _View(blackHole: result.data!);
  }

  _buildError() => _buildLoading();

  @override
  Widget build(BuildContext context) {
    Widget widget = _buildLoading();

    var snapshot =
        useFuture<ResultEntity<BlackHoleEntity>>(useMemoized(() async {
      await Future.delayed(Duration(milliseconds: 500));
      return PictureBlackHoleService.get(id);
    }), initialData: null);
    if (snapshot.hasData) {
      widget = _buildMain(snapshot.data!);
    } else {
      widget = _buildError();
    }
    return widget;
  }
}

class _View extends StatefulWidget {
  _View({Key? key, required this.blackHole}) : super(key: key);

  final BlackHoleEntity blackHole;

  @override
  _ViewState createState() => _ViewState(blackHole);
}

class _ViewState extends State<_View> {
  //目的为了脱离上级参数，因为要做识图的更改
  _ViewState(this.blackHole);

  BlackHoleEntity blackHole;

  @override
  Widget build(BuildContext context) {
    var user = blackHole.user;
    var tagList = blackHole.tagList;
    return SimpleDialog(
      title: Text("屏蔽设置"),
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
            width: Get.width,
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                _buildAvatar(user),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                    child: Text(user.nickname),
                  ),
                ),
                BlockUserIconBtn(
                    user: user,
                    callback: (UserBlackHoleEntity result, int state) {
                      setState(() {
                        result.state = state;
                      });
                    })
              ],
            )),
        Divider(),
        ..._buildTagList(tagList),
      ],
    );
  }

  List<Padding> _buildTagList(List<TagBlackHoleEntity> tagList) {
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
                  BlockTagIconBtn(
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

  InkWell _buildAvatar(UserBlackHoleEntity user) {
    var size = 75.0;
    var padding = 8.0;
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(size / 2)),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: AvatarWidget(
          user.avatarUrl,
          user.nickname,
          size: size - padding * 2,
          fit: BoxFit.cover,
          style: AvatarStyle.small50,
        ),
      ),
      onTap: () {
        Get.to(UserTabPage(id: user.id));
      },
    );
  }
}
