import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/constant/key.constant.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/util/result.util.dart';
import 'package:zeongitbeautyflutter/plugins/util/storage.util.dart';
import 'package:zeongitbeautyflutter/plugins/widget/icon_text_field.widget.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/routes.dart';

final _gap = StyleConfig.gap * 6;

class SignUpPage extends StatefulWidget {
  SignUpPage(this.phone, {Key key}) : super(key: key);

  final String phone;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _codeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _rePasswordController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool _loading = false;

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
        appBar: AppBar(title: Text("注册您的账号")),
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
                      controller: _codeController,
                      icon: MdiIcons.check,
                      hintText: '验证码',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: _gap),
                    child: IconTextField(
                      controller: _passwordController,
                      icon: MdiIcons.lock,
                      obscureText: true,
                      hintText: '密码',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: _gap * 2),
                    child: IconTextField(
                      controller: _rePasswordController,
                      icon: MdiIcons.lock_check,
                      obscureText: true,
                      hintText: '确认密码',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: _gap),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        child: _loading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                        strokeWidth: 3,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Text("注册登录中..."),
                                  )
                                ],
                              )
                            : Text("确认注册并登录"),
                        onPressed: () {
                          _signUp(context, _userState);
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  @override
  void dispose() {
    _codeController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  _signUp(BuildContext context, UserState userState) async {
    if (_loading) return;
    setState(() {
      _loading = true;
    });
    var result = await UserService.signUp(
        _codeController.text, widget.phone, _passwordController.text);
    setState(() {
      _loading = false;
    });
    if (ResultUtil.check(result)) {
      await StorageManager.setString(KeyConstant.TOKEN_KEY, result.data);
      await userState.getInfo();
      Navigator.popUntil(context, (route) {
        return route.isFirst;
      });
    } else {
      Navigator.popUntil(context, ModalRoute.withName(RoutesKey.SIGN_IN));
    }
  }
}
