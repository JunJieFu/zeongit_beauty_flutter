import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:photo_view/photo_view.dart';
import 'package:zeongitbeautyflutter/plugins/constants/config.constant.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/permission.util.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/shadow_icon.widget.dart';

class ViewPage extends StatefulWidget {
  ViewPage(this.url, {Key key}) : super(key: key);

  final String url;

  @override
  ViewPageState createState() => ViewPageState();
}

class ViewPageState extends State<ViewPage> {
  String _completeUrl;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _completeUrl = "${ConfigConstant.QINIU_PICTURE}/${widget.url}";
    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          brightness: Brightness.dark,
          leading: IconButton(
            icon: ShadowIcon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
          actions: [
            PopupMenuButton(
              icon: ShadowIcon(MdiIcons.dots_horizontal,
                  color: Colors.white),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'save',
                    child: Text('保存图片'),
                  ),
                ];
              },
              onSelected: _selectMenu,
            )
          ],
        ),
        body: PhotoView(
          imageProvider: CachedNetworkImageProvider(_completeUrl),
          loadingBuilder: (BuildContext context, ImageChunkEvent event) {
            return Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ));
  }

  _selectMenu(String value) {
    switch (value) {
      case "save":
        _saveStorage();
        break;
    }
  }

  _saveStorage() async {
    if (await PermissionUtil.storage()) {
      final success = await GallerySaver.saveImage(_completeUrl);
      if (success) {
        Fluttertoast.showToast(msg: "保存成功", gravity: ToastGravity.BOTTOM);
      } else {
        Fluttertoast.showToast(
            msg: "保存失败",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: StyleConfig.errorColor);
      }
    }
  }
}
