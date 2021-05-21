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

  final user = Rx<UserBlackHoleEntity?>(null);

  final tagList = RxList<TagBlackHoleEntity>();

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

  _buildMain(BlackHoleEntity data) {
    user.value = data.user;
    tagList.value = data.tagList;

    return Obx(
      () => SimpleDialog(
        title: Text("屏蔽设置"),
        children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
              width: Get.width,
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  _buildAvatar(user.value!),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                      child: Text(user.value!.nickname),
                    ),
                  ),
                  BlockUserIconBtn(
                      user: user.value!,
                      callback: (UserBlackHoleEntity result, int state) {
                        user.update((val) {
                          val!.state = state;
                        });
                      })
                ],
              )),
          Divider(),
          ..._buildTagList(tagList),
        ],
      ),
    );
  }

  _buildError() => _buildLoading();

  @override
  Widget build(BuildContext context) {
    Widget widget = _buildLoading();
    final snapshot =
        useFuture<ResultEntity<BlackHoleEntity>>(useMemoized(() async {
      await Future.delayed(Duration(milliseconds: 500));
      return PictureBlackHoleService.get(id);
    }), initialData: null);
    if (snapshot.hasData) {
      widget = _buildMain(snapshot.data!.data!);
    } else {
      widget = _buildError();
    }
    return widget;
  }

  List<Padding> _buildTagList(RxList<TagBlackHoleEntity> tagList) {
    return tagList.asMap().entries.map((entry) {
      final index = entry.key;
      final value = entry.value;
      return Padding(
        padding: EdgeInsets.all(StyleConfig.gap * 3),
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                child: Text(value.name),
              ),
            ),
            BlockTagIconBtn(
                tag: value,
                callback: (TagBlackHoleEntity tag, int state) {
                  tagList[index].state = state;
                  tagList.refresh();
                })
          ],
        ),
      );
    }).toList();
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
        Get.to(() => UserTabPage(id: user.id));
      },
    );
  }
}
