import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/pages/black_hole/black_hole_tab.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("设置")),
        body: ListView(children: <Widget>[
          ..._buildListTile(MdiIcons.eye_off_outline, "屏蔽设置", () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return BlackHoleTabPage();
            }));
          }),
          Divider(height: 1),
        ]));
  }

  List<Widget> _buildListTile(
      IconData icon, String title, GestureTapCallback onTap) {
    return [
      ListTile(
        onTap: onTap,
        title: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Icon(icon),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                child: Text(title),
              ),
            ),
            Icon(Icons.keyboard_arrow_right),
          ],
        ),
      )
    ];
  }
}
