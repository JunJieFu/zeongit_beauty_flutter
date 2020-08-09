import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/assets/style/index.style.dart';
import 'package:zeongitbeautyflutter/assets/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widget/fragment/link.widget.dart';

final _gap = StyleConfig.gap * 6;

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _userState = Provider.of<UserState>(context, listen: false);
    return Scaffold(
        appBar: AppBar(title: Text("登录您的账号")),
        body: Padding(
          padding: EdgeInsets.all(_gap),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: _gap),
                child: IconTextField(
                  controller: _phoneController,
                  icon: MdiIcons.cellphone,
                  hintText: '手机号码',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: _gap * 2),
                child: IconTextField(
                  controller: _passwordController,
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
                      _signIn(context, _userState);
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
        ));
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  _signIn(BuildContext context, UserState userState) async {
    var result = await UserService.signIn(
        _phoneController.text, _passwordController.text);
    if (result.status == 200) {
      await userState.getInfo();
      Navigator.maybePop(context);
    }
  }
}

class SignInItemModel {
  final Widget view;

  final Widget tab;

  SignInItemModel({this.view, this.tab});
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
  FocusNode _focusNode = FocusNode();
  bool hasFocus = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        hasFocus = _focusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
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
