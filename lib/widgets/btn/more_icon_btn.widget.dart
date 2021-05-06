import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/popup_container.widget.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widgets/black_hole_dialog.widget.dart';
import 'package:zeongitbeautyflutter/widgets/complaint.dialog.dart';
import 'package:zeongitbeautyflutter/widgets/popup.fun.dart';

class MoreIconBtn extends StatelessWidget {
  MoreIconBtn({Key key, @required this.picture, this.callback})
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
                        ListTile(
                            title: Text("屏蔽"),
                            onTap: () {
                              Navigator.of(context).pop(this);
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return BlackHoleDialog(
                                      id: picture.id,
                                    );
                                  });
                            }),
                        Divider(height: 1),
                        ListTile(
                          title: Text("举报"),
                          onTap: () {
                            Navigator.of(context).pop(this);
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return ComplaintDialog(
                                    picture: picture,
                                  );
                                });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          popupSignIn("想要关于绘画的更多操作？", "请先登录，然后才能获取更多绘画操作。", context, _btnKey);
        }
      },
    );
  }
}
