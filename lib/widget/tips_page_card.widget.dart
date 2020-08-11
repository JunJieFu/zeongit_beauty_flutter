import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/pages/sign_in.page.dart';
import 'file:///D:/project/flutter/zeongit_beauty_flutter/lib/plugins/widget/card.widget.dart';

import 'file:///D:/project/flutter/zeongit_beauty_flutter/lib/plugins/widget/title.widget.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/text.widget.dart';

class TipsPageCardWidget extends StatelessWidget {
  TipsPageCardWidget(
      {Key key, this.icon, this.title, this.text, this.btnDesc, this.onPressed})
      : super(key: key);

  final IconData icon;
  final String title;
  final String text;
  final String btnDesc;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Column(
          children: _columnChildren(),
        ));
  }

  List<Widget> _columnChildren() {
    var list = [
      Padding(
        padding: EdgeInsets.only(top: StyleConfig.gap * 12),
        child: Icon(icon, size: 100),
      ),
      CardTitleWidget(child: TitleWidget(title)),
      CardTextWidget(child: TextWidget(text))
    ];
    if (btnDesc != null) {
      list.add(OutlineButton(
          child: Text(btnDesc),
          borderSide: BorderSide(
            color: StyleConfig.primaryColor,
          ),
          onPressed: onPressed));
    }
    return list;
  }
}

class SignInPageCardWidget extends StatelessWidget {
  SignInPageCardWidget({Key key, this.icon, this.title, this.text})
      : super(key: key);

  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TipsPageCardWidget(
      icon: icon,
      title: title,
      text: text,
      btnDesc: "登录",
      onPressed: () {
        print(1);
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return SignInPage();
        }));
      },
    );
  }
}
