import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/assets/style/index.style.dart';
import 'package:zeongitbeautyflutter/assets/style/mdi_icons.style.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  TextEditingController _phoneController = TextEditingController(text: "初始化的");
  TextEditingController _passwordController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        print(_focusNode.hasFocus);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("登录您的账号")),
        body: Padding(
          padding: EdgeInsets.all(StyleConfig.gap * 2),
          child: Column(
            children: <Widget>[
              TextField(
                focusNode: _focusNode,
                controller: _phoneController,
                cursorColor: StyleConfig.primaryColor,
                decoration: InputDecoration(
                  isDense:false,
                  focusColor: StyleConfig.primaryColor,
                  prefixIcon: Icon(MdiIcons.cellphone,
                      color: StyleConfig.primaryColor),
                  hintText: '手机号码',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: StyleConfig.primaryColor)),
                ),
              ),
              TextField(
                cursorColor: StyleConfig.primaryColor,
                controller: _passwordController,
                decoration: InputDecoration(
                  isDense:false,
                  focusColor: StyleConfig.primaryColor,
                  prefixIcon: Icon(MdiIcons.lock,
                      color: StyleConfig.primaryColor),
                  hintText: '密码',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: StyleConfig.primaryColor)),
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
