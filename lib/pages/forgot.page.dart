import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/util/result.util.dart';
import 'package:zeongitbeautyflutter/plugins/widget/icon_text_field.widget.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/routes.dart';

final _gap = StyleConfig.gap * 6;

class ForgetPage extends StatefulWidget {
  ForgetPage(this.phone, {Key key}) : super(key: key);

  final String phone;

  @override
  _ForgetPageState createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> with TickerProviderStateMixin {
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool loading = false;

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
        appBar: AppBar(title: Text("找回您的密码")),
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
                      controller: codeController,
                      icon: MdiIcons.check,
                      hintText: '验证码',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: _gap),
                    child: IconTextField(
                      controller: passwordController,
                      icon: MdiIcons.lock,
                      obscureText: true,
                      hintText: '密码',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: _gap * 2),
                    child: IconTextField(
                      controller: rePasswordController,
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
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: StyleConfig.primaryColor,
                        child: loading
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
                          forget(context, _userState);
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
    super.dispose();
    codeController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }

  forget(BuildContext context, UserState userState) async {
    if (loading) return;
    setState(() {
      loading = true;
    });
    var result = await UserService.forgot(
        codeController.text, widget.phone, passwordController.text);
    setState(() {
      loading = false;
    });
    try{
      await ResultUtil.check(result);
      Navigator.popUntil(context, ModalRoute.withName(RoutesKey.SIGN_IN));
    }catch(e){}
  }
}
