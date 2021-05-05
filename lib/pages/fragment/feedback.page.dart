import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';

final _gap = StyleConfig.gap * 6;

class FeedbackPage extends HookWidget {
  FeedbackPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: ElevatedButton(onPressed: () {}, child: Text("提交"))),
          )
        ]));
  }
}
