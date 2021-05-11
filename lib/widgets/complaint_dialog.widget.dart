import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/result.util.dart';

class ComplaintDialog extends HookWidget {
  ComplaintDialog({Key key, @required this.id}) : super(key: key);

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
              "提交中...",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);

    var contentFocusNode = useFocusNode();
    var contentController = useTextEditingController();
    var contentHasFocus = useState(false);

    contentFocusNode.addListener(() {
      contentHasFocus.value = contentFocusNode.hasFocus;
    });

    save() async {
      if (loading.value) return;
      final content = contentController.text;
      if (content == null || content == '') {
        BotToast.showText(text: "请输入举报内容");
        return;
      }
      loading.value = true;
      final result = await ComplaintService.save(id, content);
      await Future.delayed(Duration(milliseconds: 500));
      if (!ResultUtil.check(result)) {
        loading.value = false;
        return;
      } else {
        BotToast.showText(text: "提交成功");
        Get.back();
      }
    }

    return loading.value
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
                  labelStyle: TextStyle(
                      color: contentHasFocus.value ? Colors.blue : null)),
            ),
            actions: <Widget>[
              TextButton(
                  style: TextButton.styleFrom(
                    primary: StyleConfig.warningColor,
                  ),
                  onPressed: Get.back,
                  child: Text("取消")),
              TextButton(onPressed: save, child: Text("确定"))
            ],
          );
  }
}
