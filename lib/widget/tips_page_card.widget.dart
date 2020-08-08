import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/assets/style/index.style.dart';
import 'package:zeongitbeautyflutter/pages/sign_in.page.dart';
import 'package:zeongitbeautyflutter/widget/fragment/card.widget.dart';
import 'package:zeongitbeautyflutter/widget/fragment/text.widget.dart';
import 'package:zeongitbeautyflutter/widget/fragment/title.widget.dart';

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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: StyleConfig.gap * 12),
          child: Icon(icon, size: 100),
        ),
        CardTitleWidget(child: TitleWidget(title)),
        CardTextWidget(child: TextWidget(text)),
        btnDesc != null
            ? OutlineButton(
                child: Text(btnDesc),
                borderSide: BorderSide(
                  color: StyleConfig.primaryColor,
                ),
                onPressed: onPressed)
            : null
      ],
    );
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
