import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/sign_up.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/util/result.util.dart';
import 'package:zeongitbeautyflutter/plugins/widget/icon_text_field.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/link.widget.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';

import '../assets/constant/enum.constant.dart';

class _DifferenceModel {
  _DifferenceModel(this.text, this.linkList);

  final String text;

  final List<Widget> linkList;
}

final _gap = StyleConfig.gap * 6;
final _differenceList = {
  CodeTypeConstant.SIGN_UP: _DifferenceModel("注册您的账号", [
    Padding(
      padding: EdgeInsets.only(bottom: _gap / 2),
      child: LinkWidget("忘记了登录密码？"),
    ),
    LinkWidget("已经有登录账号？")
  ]),
  CodeTypeConstant.FORGOT: _DifferenceModel("找回您的密码", [
    Padding(
      padding: EdgeInsets.only(bottom: _gap / 2),
      child: LinkWidget("已经有登录账号？"),
    ),
    LinkWidget("没有登录账号，立即创建一个！"),
  ])
};

class SignCodePage extends StatefulWidget {
  SignCodePage(this.codeType, {Key key}) : super(key: key);

  final CodeTypeConstant codeType;

  @override
  SignCodePageState createState() => SignCodePageState();
}

class SignCodePageState extends State<SignCodePage>
    with TickerProviderStateMixin {
  TextEditingController phoneController = TextEditingController();
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
    var currDifference = _differenceList[widget.codeType];
    return Scaffold(
        appBar: AppBar(title: Text(currDifference.text)),
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
                                    child: Text("发送中..."),
                                  )
                                ],
                              )
                            : Text("获取验证码"),
                        onPressed: () {
                          signIn(context, _userState);
                        },
                      ),
                    ),
                  ),
                  ...currDifference.linkList
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
    if (loading) return;
    setState(() {
      loading = true;
    });
    var result =
        await UserService.sendCode(phoneController.text, widget.codeType);
    setState(() {
      loading = false;
    });
    await ResultUtil.check(result);
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return SignUpPage(phoneController.text);
    }));
//    Navigator.maybePop(context);
  }
}
