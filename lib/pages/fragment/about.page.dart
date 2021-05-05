import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("关于")),
        body: TipsPageCard(
            icon: MdiIcons.information_outline, title: "关于", text: "尚在开发。"));
  }
}
