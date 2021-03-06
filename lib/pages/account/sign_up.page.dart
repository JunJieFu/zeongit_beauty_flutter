import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/constants/key.constant.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/text_editing_controller.hook.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/result.util.dart';
import 'package:zeongitbeautyflutter/plugins/utils/storage.util.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/icon_text_field.widget.dart';
import 'package:zeongitbeautyflutter/provider/account.logic.dart';

final _gap = StyleConfig.gap * 6;

class SignUpPage extends HookWidget {
  SignUpPage(this.phone, {Key? key}) : super(key: key);

  final String phone;

  final _accountLogic = Get.find<AccountLogic>();

  final code = "".obs;

  final password = "".obs;

  final rePassword = "".obs;

  final _loading = false.obs;

  _signUp() async {
    if (_loading.value) return;
    _loading.value = true;
    var result = await UserService.signUp(code.value, phone, password.value);
    if (ResultUtil.check(result)) {
      await StorageManager.setString(KeyConstant.TOKEN_KEY, result.data!);
      await _accountLogic.getInfo();
      Get.until((route) => route.isFirst);
    }
    _loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final codeController = useTextEditingControllerObs(code);
    final passwordController = useTextEditingControllerObs(password);
    final rePasswordController = useTextEditingControllerObs(rePassword);
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
                      height: StyleConfig.buttonHeight,
                      child: Obx(
                        () => ElevatedButton(
                          child: _loading.value
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
                          onPressed: _signUp,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
