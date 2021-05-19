import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/constants/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/pages/account/forgot.page.dart';
import 'package:zeongitbeautyflutter/pages/account/sign_up.page.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/result.util.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/icon_text_field.widget.dart';

final _gap = StyleConfig.gap * 6;
final _differenceList = {
  CodeTypeConstant.SIGN_UP: "注册您的账号",
  CodeTypeConstant.FORGOT: "找回您的密码"
};

class SignCodePage extends HookWidget {
  SignCodePage(this.codeType, {Key? key}) : super(key: key);

  final CodeTypeConstant codeType;

  @override
  Widget build(BuildContext context) {
    final phoneController = useTextEditingController();

    final loading = useState(false);

    send() async {
      if (loading.value) return;
      loading.value = true;
      var result = await UserService.sendCode(phoneController.text, codeType);
      if (ResultUtil.check(result)) {
        if (codeType == CodeTypeConstant.SIGN_UP) {
          Get.to(SignUpPage(phoneController.text));
        } else if (codeType == CodeTypeConstant.FORGOT) {
          Get.to(ForgetPage(phoneController.text));
        }
      }
      loading.value = false;
    }

    return Scaffold(
        appBar: AppBar(title: Text(_differenceList[codeType]!)),
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
                      controller: phoneController,
                      icon: MdiIcons.cellphone,
                      hintText: '手机号码',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: _gap),
                    child: SizedBox(
                      width: double.infinity,
                      height: StyleConfig.buttonHeight,
                      child: ElevatedButton(
                        child: loading.value
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
                        onPressed: send,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
