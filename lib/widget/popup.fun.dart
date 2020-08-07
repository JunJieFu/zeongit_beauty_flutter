import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zeongitbeautyflutter/assets/style/index.style.dart';
import 'package:zeongitbeautyflutter/pages/sign_in.page.dart';

import 'fragment/card.widget.dart';
import 'fragment/popup_container.widget.dart';
import 'fragment/text.widget.dart';
import 'fragment/title.widget.dart';

void popupSignIn(String title, String text, BuildContext context,
    GlobalKey targetRenderKey) {
  Navigator.push(
    context,
    PopupContainerRoute(
      child: PopupContainer(
        targetRenderKey: targetRenderKey,
        child: Card(
          child: Container(
            width: 250,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CardTitleWidget(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TitleWidget(title),
                    TextWidget(text),
                  ],
                )),
                Divider(),
                CardTextWidget(Align(
                  alignment: Alignment.centerRight,
                  child: OutlineButton(
                      child: Text("登录"),
                      borderSide: BorderSide(
                        color: StyleConfig.primaryColor,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return SignInPage();
                        }));
                      }),
                ))
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
