import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/util/result.util.dart';
import 'package:zeongitbeautyflutter/plugins/widget/link.widget.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';

final _gap = StyleConfig.gap * 6;

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _userState = Provider.of<UserState>(context, listen: false);
    return Scaffold(
        appBar: AppBar(title: Text("登录您的账号")),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(_gap),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: _gap),
                    child: IconTextField(
                      controller: phoneController,
                      icon: MdiIcons.cellphone,
                      hintText: '手机号码',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: _gap * 2),
                    child: IconTextField(
                      controller: passwordController,
                      icon: MdiIcons.lock,
                      obscureText: true,
                      hintText: '密码',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: _gap),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: RaisedButton(
                        child: Text("登录"),
                        onPressed: () {
                          signIn(context, _userState);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: _gap / 2),
                    child: LinkWidget("忘记了登录密码？"),
                  ),
                  LinkWidget("已经有登录账号？"),
                ],
              ),
            )
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  signIn(BuildContext context, UserState userState) async {
    var result = await UserService.signIn(
        phoneController.text, passwordController.text);
    await ResultUtil.check(result);
    await userState.getInfo();
    Navigator.maybePop(context);
  }
}

class IconTextField extends StatefulWidget {
  IconTextField(
      {Key key,
      this.controller,
      this.obscureText = false,
      this.hintText,
      this.icon})
      : super(key: key);

  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final IconData icon;

  @override
  _IconTextFieldState createState() => _IconTextFieldState();
}

class _IconTextFieldState extends State<IconTextField> {
  FocusNode focusNode = FocusNode();
  bool hasFocus = false;

  @override
  void initState() {
    focusNode.addListener(() {
      setState(() {
        hasFocus = focusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: widget.controller,
      obscureText: widget.obscureText,
      cursorColor: StyleConfig.primaryColor,
      decoration: InputDecoration(
        isDense: false,
        focusColor: StyleConfig.primaryColor,
        prefixIcon: Icon(widget.icon,
            color: hasFocus ? StyleConfig.primaryColor : null),
        hintText: widget.hintText,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: StyleConfig.primaryColor)),
      ),
    );
  }
}
