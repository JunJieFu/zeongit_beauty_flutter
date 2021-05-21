import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/focus_node.hook.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/text_editing_controller.hook.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/result.util.dart';

final _gap = StyleConfig.gap * 6;

class FeedbackPage extends HookWidget {
  FeedbackPage({Key? key}) : super(key: key);

  final _loading = false.obs;

  final _content = "".obs;
  final _email = "".obs;

  final _contentHasFocus = true.obs;
  final _emailHasFocus = false.obs;

  save() async {
    if (_loading.value) return;
    if (_content.value == '') {
      BotToast.showText(text: "请输入反馈内容");
      return;
    }
    _loading.value = true;
    final result =
        await FeedbackService.save(_content.value, email: _email.value);
    _loading.value = false;
    if (!ResultUtil.check(result)) return;
    BotToast.showText(text: "提交成功");
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final contentController = useTextEditingControllerObs(_content);
    final emailController = useTextEditingControllerObs(_email);
    final contentFocusNode = useFocusNodeObs(_contentHasFocus);
    final emailFocusNode = useFocusNodeObs(_emailHasFocus);

    return Scaffold(
        appBar: AppBar(title: Text("反馈")),
        body: Obx(
          () => ListView(children: [
            Padding(
              padding: EdgeInsets.all(_gap),
              child: TextFormField(
                autofocus: true,
                focusNode: contentFocusNode,
                controller: contentController,
                maxLines: 8,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    labelText: '请告诉我您遇到的问题',
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(
                        color: _contentHasFocus.value ? Colors.blue : null)),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(_gap, 0, _gap, _gap),
              child: TextFormField(
                focusNode: emailFocusNode,
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    labelText: '邮箱',
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(
                        color: _emailHasFocus.value ? Colors.blue : null)),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(_gap, 0, _gap, _gap),
              child: SizedBox(
                  height: StyleConfig.buttonHeight,
                  child: ElevatedButton(
                      onPressed: save,
                      child: _loading.value
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                      strokeWidth: 3,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Text("提交中..."),
                                )
                              ],
                            )
                          : Text("提交"))),
            )
          ]),
        ));
  }
}
