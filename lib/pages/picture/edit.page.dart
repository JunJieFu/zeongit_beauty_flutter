import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:photo_view/photo_view.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/plugins/util/permission.util.dart';

import '../../plugins/constant/config.constant.dart';
import '../../plugins/style/index.style.dart';
import '../../plugins/style/mdi_icons.style.dart';
import '../../plugins/widget/shadow_icon.widget.dart';

class EditPage extends StatefulWidget {
  EditPage(this.picture, {Key key,@required this.callback}) : super(key: key);

  final PictureEntity picture;

  final void Function(PictureEntity) callback;

  @override
  EditPageState createState() => EditPageState(picture);
}

class EditPageState extends State<EditPage> {
  EditPageState(this.picture);

  PictureEntity picture;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("编辑"),
        ),
        body: Container());
  }
}
