import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:photo_view/photo_view.dart';
import 'package:zeongitbeautyflutter/plugins/util/permission.util.dart';

import '../../plugins/constant/config.constant.dart';
import '../../plugins/style/index.style.dart';
import '../../plugins/style/mdi_icons.style.dart';
import '../../plugins/widget/shadow_icon.widget.dart';

class ViewPage extends StatefulWidget {
  ViewPage(this.url, {Key key}) : super(key: key);

  final String url;

  @override
  ViewPageState createState() => ViewPageState();
}

class ViewPageState extends State<ViewPage> {
  CachedNetworkImageProvider cached;

  @override
  Widget build(BuildContext context) {
    cached = CachedNetworkImageProvider(
        "${ConfigConstant.QINIU_PICTURE}/${widget.url}");
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: ShadowIconWidget(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
          actions: [
            PopupMenuButton(
              icon: ShadowIconWidget(MdiIcons.dots_horizontal,
                  color: Colors.white),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'save',
                    child: Text('保存图片'),
                  ),
                ];
              },
              onSelected: selectMenu,
            )
          ],
        ),
        body: PhotoView(
          imageProvider: cached,
          loadingBuilder: (BuildContext context, ImageChunkEvent event) {
            return Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ));
  }

  selectMenu(String value) {
    switch (value) {
      case "save":
        saveStorage();
        break;
    }
  }

  saveStorage() async {
    if (await PermissionUtil.storage()) {
      DefaultCacheManager manager =
          cached?.cacheManager ?? DefaultCacheManager();
      Map<String, String> headers = cached?.headers;
      var file = await manager.getSingleFile(
        cached.url,
        headers: headers,
      );
      final result =
          await ImageGallerySaver.saveImage(await file.readAsBytes());

      if (result == null || result == '') {
        Fluttertoast.showToast(
            msg: "保存失败",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: StyleConfig.errorColor);
      } else {
        Fluttertoast.showToast(msg: "保存成功", gravity: ToastGravity.BOTTOM);
      }
    }
  }
}
