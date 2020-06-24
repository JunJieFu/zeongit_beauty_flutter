import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      elevation: 1,
      title: TextField(
        autofocus: true,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        )
      ],
    ),
      body: WebView(
        initialUrl: "https://fanyi.baidu.com/",
        //JS执行模式 是否允许JS执行
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
