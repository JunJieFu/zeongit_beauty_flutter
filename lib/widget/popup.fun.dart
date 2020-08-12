import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:zeongitbeautyflutter/pages/sign_in.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/popup_container.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/text.widget.dart';

import '../plugins/widget/card.widget.dart';
import '../plugins/widget/title.widget.dart';

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
                CardTitleWidget(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TitleWidget(title),
                    TextWidget(text),
                  ],
                )),
                Divider(height: 1),
                Padding(
                  padding: EdgeInsets.only(
                      right: StyleConfig.gap * 3,
                      bottom: StyleConfig.gap,
                      top: StyleConfig.gap),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: OutlineButton(
                        textColor: StyleConfig.primaryColor,
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
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
