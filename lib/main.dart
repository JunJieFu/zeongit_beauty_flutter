import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/pages/home/tab.page.dart';
import 'package:zeongitbeautyflutter/pages/welcome.page.dart';
import 'package:zeongitbeautyflutter/plugins/utils/permission.util.dart';
import 'package:zeongitbeautyflutter/plugins/utils/storage.util.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/config.widget.dart';
import 'package:zeongitbeautyflutter/provider/account.logic.dart';
import 'package:zeongitbeautyflutter/provider/fragment.logic.dart';
import 'package:zeongitbeautyflutter/provider/theme.logic.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _init();
}

_init() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await StorageManager.init();
  PermissionUtil.storage();
  runApp(App());
}

const List<Locale> an = [const Locale('zh', 'CH')];
const List<Locale> ios = [const Locale('en', 'US')];

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ThemeLogic());
    Get.lazyPut(() => FragmentLogic());
    Get.lazyPut(() => AccountLogic());
    final fragmentLogic = Get.find<FragmentLogic>();
    final themeLogic = Get.find<ThemeLogic>();

    return GetMaterialApp(
      theme: themeLogic.getTheme(),
      home: Obx(() => DefaultRefreshConfiguration(
          child: fragmentLogic.hasInit ? TabPage() : WelcomePage())),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: Platform.isIOS ? ios : an,
      locale: Locale('zh'),
    );
  }
}
