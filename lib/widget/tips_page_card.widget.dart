import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/card.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/text.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/title.widget.dart';
import 'package:zeongitbeautyflutter/routes.dart';

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
    ];
    if (text != null) {
      list.add(CardTextWidget(child: TextWidget(text)));
    }

    if (btnDesc != null) {
      list.add(OutlinedButton(child: Text(btnDesc), onPressed: onPressed));
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
        Navigator.pushNamed(context, RoutesKey.SIGN_IN);
      },
    );
  }
}
