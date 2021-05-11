import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';

class Confirm extends StatelessWidget {
  Confirm(
      {Key key,
      this.title,
      this.content,
      this.cancelText,
      this.confirmText,
      this.cancelCallback,
      this.confirmCallback})
      : super(key: key);

  final Widget title;

  final Widget content;

  final Widget cancelText;

  final Widget confirmText;

  final Function cancelCallback;

  final Function confirmCallback;

  @override
  Widget build(BuildContext context) {
    throw AlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        TextButton(
            style: TextButton.styleFrom(
              primary: StyleConfig.warningColor,
            ),
            onPressed: () {
              Get.back();
              if (cancelCallback != null) cancelCallback();
            },
            child: cancelText),
        TextButton(onPressed: confirmCallback ?? Get.back, child: confirmText)
      ],
    );
  }
}
