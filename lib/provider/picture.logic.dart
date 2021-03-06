import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/constants/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/utils/result.util.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/comfir.widget.dart';

const String PICTURE_LOGIC_TAG_PREFIX = "PICTURE:";

class PictureLogic extends GetxController {
  final PictureEntity? initial;

  final Rx<PictureEntity?> _picture;

  final loading = false.obs;

  PictureLogic(this.initial) : _picture = Rx<PictureEntity?>(initial);

  PictureEntity? get picture => _picture.value;

  get aspectRatio => (picture != null) ? picture!.width / picture!.height : 1.0;

  set(PictureEntity p) {
    _picture.value = p;
  }

  remove() {
    showDialog(
        context: Get.context!,
        builder: (ctx) {
          return Confirm(
            title: Text("提示"),
            content: Text("您确定删除该图片吗？"),
            cancelText: Text("取消"),
            confirmText: Text("确定"),
            confirmCallback: () async {
              Get.back();
              var result = await PictureService.remove(picture!.id);
              if (ResultUtil.check(result)) {
                BotToast.showText(text: "删除成功");
              }
            },
          );
        });
  }

  hide() {
    final privacy = picture!.privacy == PrivacyState.PRIVATE.index;
    showDialog(
        context: Get.context!,
        builder: (ctx) {
          return Confirm(
            title: Text("提示"),
            content: Text("您确定${privacy ? "公开" : "隐藏"}该图片吗？"),
            cancelText: Text("取消"),
            confirmText: Text("确定"),
            confirmCallback: () async {
              Get.back();
              BotToast.showText(text: "尚未开发");
            },
          );
        });
  }

  collect() async {
    if (loading.value) return;
    loading.value = true;
    var result = await CollectionService.focus(picture!.id);
    loading.value = false;
    if (ResultUtil.check(result)) {
      _picture.update((val) {
        val!.focus = result.data!;
      });
    }
  }

  @override
  onInit() {
    super.onInit();
    _picture.value = initial;
  }
}
