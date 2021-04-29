import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/constant/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/account/sign_up.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/util/result.util.dart';
import 'package:zeongitbeautyflutter/plugins/widget/icon_text_field.widget.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';

final _gap = StyleConfig.gap * 6;
final _differenceList = {
  CodeTypeConstant.SIGN_UP: "注册您的账号",
  CodeTypeConstant.FORGOT: "找回您的密码"
};

class SignCodePage extends StatefulWidget {
  SignCodePage(this.codeType, {Key key}) : super(key: key);

  final CodeTypeConstant codeType;

  @override
  SignCodePageState createState() => SignCodePageState();
}

class SignCodePageState extends State<SignCodePage> {
  TextEditingController _phoneController = TextEditingController();
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
        appBar: AppBar(title: Text(_differenceList[widget.codeType])),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(_gap),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: _gap * 2),
                    child: IconTextField(
                      controller: _phoneController,
                      icon: MdiIcons.cellphone,
                      hintText: '手机号码',
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
                                    child: Text("发送中..."),
                                  )
                                ],
                              )
                            : Text("获取验证码"),
                        onPressed: () {
                          _send(context, _userState);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  _send(BuildContext context, UserState userState) async {
    if (_loading) return;
    setState(() {
      _loading = true;
    });
    var result =
        await UserService.sendCode(_phoneController.text, widget.codeType);
    setState(() {
      _loading = false;
    });
    if (ResultUtil.check(result)) {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return SignUpPage(_phoneController.text);
      }));
    }
  }
}
