import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/pages/picture/widget/black_hole_dialog.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/popup_container.widget.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widget/popup.fun.dart';

class MoreBtn extends StatelessWidget {
  MoreBtn({Key key, @required this.picture, @required this.callback})
      : super(key: key);
  final GlobalKey _btnKey = GlobalKey();

  final PictureEntity picture;

  final Function callback;

  @override
  Widget build(BuildContext context) {
    var userState = Provider.of<UserState>(context, listen: false);
    return IconButton(
      key: _btnKey,
      icon: Icon(Icons.more_vert),
      onPressed: () {
        if (userState.info != null) {
          Navigator.push(
            context,
            PopupContainerRoute(
              child: PopupContainer(
                targetRenderKey: _btnKey,
                child: Card(
                  child: Container(
                    width: 150,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(title: Text("屏蔽"), onTap: () {
                          Navigator.of(context).pop(this);
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return BlackHoleDialogWidget(
                                  id: picture.id,
                                );
                              });
                        }),
                        Divider(height: 1),
                        ListTile(
                          title: Text("举报"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          popupSignIn("想要关注这个画师？", "请先登录，然后才能成为该画师的粉丝。", context, _btnKey);
        }
      },
    );
  }
}
