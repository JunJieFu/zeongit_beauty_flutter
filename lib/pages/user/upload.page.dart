import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class UploadPage extends StatelessWidget {
  UploadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("上传")),
        body: TipsPageCard(
            icon: MdiIcons.upload_outline, title: "上传", text: "尚在开发。"));
  }
}
