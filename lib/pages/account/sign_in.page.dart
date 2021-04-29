import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/constant/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/constant/key.constant.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/account/sign_code.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/util/result.util.dart';
import 'package:zeongitbeautyflutter/plugins/util/storage.util.dart';
import 'package:zeongitbeautyflutter/plugins/widget/icon_text_field.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/link.widget.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';

final _gap = StyleConfig.gap * 6;

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
                                    child: Text("登录中..."),
                                  )
                                ],
                              )
                            : Text("登录"),
                        onPressed: () {
                          _signIn(context, _userState);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: _gap / 2),
                    child: LinkWidget("忘记了登录密码？", onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return SignCodePage(CodeTypeConstant.FORGOT);
                      }));
                    }),
                  ),
                  LinkWidget("没有登录账号，立即创建一个！", onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return SignCodePage(CodeTypeConstant.SIGN_UP);
                    }));
                  }),
                ],
              ),
            )
          ],
        ));
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _signIn(BuildContext context, UserState userState) async {
    if (_loading) return;
    setState(() {
      _loading = true;
    });
    var result = await UserService.signIn(
        _phoneController.text, _passwordController.text);
    setState(() {
      _loading = false;
    });
    if (ResultUtil.check(result)) {
      await StorageManager.setString(KeyConstant.TOKEN_KEY, result.data);
      await userState.getInfo();
      Navigator.maybePop(context);
    }
  }
}
