import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/assets/style/index.style.dart';
import 'package:zeongitbeautyflutter/assets/style/mdi_icons.style.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("登录您的账号")),
        body: Padding(
          padding: EdgeInsets.all(StyleConfig.gap * 2),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  prefix: Icon(MdiIcons.cellphone),
                  hintText: "手机号码",
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefix: Icon(MdiIcons.lock),
                  hintText: "密码",
                ),
              )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}

class SignInItemModel {
  final Widget view;

  final Widget tab;

  SignInItemModel({this.view, this.tab});
}
