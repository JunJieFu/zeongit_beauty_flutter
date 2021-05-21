import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/focus_node.hook.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/text_editing_controller.hook.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/result.util.dart';

class ComplaintDialog extends HookWidget {
  ComplaintDialog({Key? key, required this.id}) : super(key: key);

  final int id;

  final _content = "".obs;

  final _focus = true.obs;

  final _loading = false.obs;

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
              "提交中...",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  _save() async {
    if (_loading.value) return;
    if (_content.value == '') {
      BotToast.showText(text: "请输入举报内容");
      return;
    }
    _loading.value = true;
    final result = await ComplaintService.save(id, _content.value);
    await Future.delayed(Duration(milliseconds: 500));
    if (!ResultUtil.check(result)) {
      _loading.value = false;
      return;
    } else {
      BotToast.showText(text: "提交成功");
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final contentController = useTextEditingControllerObs(_content);
    final contentFocusNode = useFocusNodeObs(_focus);

    return Obx(() => _loading.value
        ? _buildLoading()
        : AlertDialog(
            content: TextFormField(
              autofocus: true,
              focusNode: contentFocusNode,
              controller: contentController,
              maxLines: 4,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  labelText: '请告诉我您为什么要举报该图片',
                  alignLabelWithHint: true,
                  labelStyle:
                      TextStyle(color: _focus.value ? Colors.blue : null)),
            ),
            actions: <Widget>[
              TextButton(
                  style: TextButton.styleFrom(
                    primary: StyleConfig.warningColor,
                  ),
                  onPressed: Get.back,
                  child: Text("取消")),
              TextButton(onPressed: _save, child: Text("确定"))
            ],
          ));
  }
}
