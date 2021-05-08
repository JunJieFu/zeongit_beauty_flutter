import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/result.util.dart';

final _gap = StyleConfig.gap * 6;

class FeedbackPage extends HookWidget {
  FeedbackPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loading = useState(false);

    var emailFocusNode = useFocusNode();
    var emailController = useTextEditingController();
    var emailHasFocus = useState(false);

    var contentFocusNode = useFocusNode();
    var contentController = useTextEditingController();
    var contentHasFocus = useState(false);

    emailFocusNode.addListener(() {
      emailHasFocus.value = emailFocusNode.hasFocus;
    });
    contentFocusNode.addListener(() {
      contentHasFocus.value = contentFocusNode.hasFocus;
    });

    save() async {
      if (loading.value) return;
      final content = contentController.text;
      final email = emailController.text;
      if (content == null || content == '') {
        BotToast.showText(text: "请输入反馈内容");
        return;
      }
      loading.value = true;
      final result = await FeedbackService.save(content, email: email);
      loading.value = false;
      if (!ResultUtil.check(result)) return;
      BotToast.showText(text: "提交成功");
      Navigator.maybePop(context);
    }

    return Scaffold(
        appBar: AppBar(title: Text("反馈")),
        body: ListView(children: [
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
                      color: contentHasFocus.value ? Colors.blue : null)),
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
                      color: emailHasFocus.value ? Colors.blue : null)),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(_gap, 0, _gap, _gap),
            child: SizedBox(
                height: StyleConfig.buttonHeight,
                child: ElevatedButton(
                    onPressed: save,
                    child: loading.value
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
        ]));
  }
}
