import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:zeongitbeautyflutter/plugins/constants/config.constant.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/permission.util.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/shadow_icon.widget.dart';

class ViewPage extends HookWidget {
  ViewPage(this.url, {Key? key}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    final completeUrl = "${ConfigConstant.QINIU_PICTURE}/$url";
    saveStorage() async {
      if (await PermissionUtil.storage()) {
        final success = await GallerySaver.saveImage(completeUrl);
        if (success != null && success) {
          BotToast.showText(text: "保存成功");
        } else {
          BotToast.showText(text: "保存失败");
        }
      }
    }

    selectMenu(String value) {
      switch (value) {
        case "save":
          saveStorage();
          break;
      }
    }

    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          brightness: Brightness.dark,
          leading: IconButton(
            icon: ShadowIcon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            PopupMenuButton(
              icon: ShadowIcon(MdiIcons.dots_horizontal, color: Colors.white),
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
          imageProvider: CachedNetworkImageProvider(completeUrl),
          loadingBuilder: (BuildContext context, ImageChunkEvent? event) {
            return Center(
                child: Container(
              child: CircularProgressIndicator(),
            ));
          },
        ));
  }
}
