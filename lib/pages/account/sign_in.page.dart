import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/constants/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/pages/account/sign_code.page.dart';
import 'package:zeongitbeautyflutter/plugins/constants/key.constant.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/result.util.dart';
import 'package:zeongitbeautyflutter/plugins/utils/storage.util.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/icon_text_field.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/link.widget.dart';
import 'package:zeongitbeautyflutter/provider/account.logic.dart';

final _gap = StyleConfig.gap * 6;

class SignInPage extends HookWidget {
  final _accountLogic = Get.find<AccountLogic>();

  @override
  Widget build(BuildContext context) {
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final loading = useState(false);
    signIn() async {
      if (loading.value) return;
      loading.value = true;
      var result = await UserService.signIn(
          phoneController.text, passwordController.text);
      if (ResultUtil.check(result)) {
        await StorageManager.setString(KeyConstant.TOKEN_KEY, result.data);
        await _accountLogic.getInfo();
        Get.back();
      }
      loading.value = false;
    }

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
                                    child: Text("登录中..."),
                                  )
                                ],
                              )
                            : Text("登录"),
                        onPressed: signIn,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: _gap / 2),
                    child: Link("忘记了登录密码？", onTap: () {
                      Get.to(SignCodePage(CodeTypeConstant.FORGOT));
                    }),
                  ),
                  Link("没有登录账号，立即创建一个！", onTap: () {
                    Get.to(SignCodePage(CodeTypeConstant.SIGN_UP));
                  }),
                ],
              ),
            )
          ],
        ));
  }
}
