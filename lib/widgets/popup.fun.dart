import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zeongitbeautyflutter/pages/account/sign_in.page.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/card.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/popup_container.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/text.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/title.widget.dart';

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
                CardTitle(
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
                    child: OutlinedButton(
                        child: Text("登录"),
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
