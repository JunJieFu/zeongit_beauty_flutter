import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/pages/home/tab.page.dart';
import 'package:zeongitbeautyflutter/pages/welcome.page.dart';
import 'package:zeongitbeautyflutter/plugins/utils/permission.util.dart';
import 'package:zeongitbeautyflutter/plugins/utils/storage.util.dart';
import 'package:zeongitbeautyflutter/plugins/utils/theme.util.dart';
import 'package:zeongitbeautyflutter/provider/fragment.logic.dart';
import 'package:zeongitbeautyflutter/provider/theme.logic.dart';
import 'package:zeongitbeautyflutter/provider/user.logic.dart';
import 'package:zeongitbeautyflutter/routes.dart';

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
    Get.lazyPut(() => UserLogic());
    final fragmentLogic = Get.find<FragmentLogic>();
    final themeLogic = Get.find<ThemeLogic>();

    /// 在异步操作时,显示的页面
    return  GetMaterialApp(
      theme: themeLogic.getTheme(),
      home: Builder(builder: (ctx) {
        var primaryColor = Theme
            .of(ctx)
            .primaryColor;
        return RefreshConfiguration(
          headerBuilder: () =>
              MaterialClassicHeader(
                color: primaryColor,
                backgroundColor: Get.theme.brightness == Brightness.dark ? Get.theme
                    .cardColor : Colors.white,
              ),
          footerBuilder: () =>
              CustomFooter(
                  builder: (BuildContext context, LoadStatus mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text("上拉加载");
                    } else if (mode == LoadStatus.loading) {
                      body = CircularProgressIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = Text("加载失败，点击重试");
                    } else if (mode == LoadStatus.canLoading) {
                      body = Text("松手加载更多");
                    } else {
                      body = Text("没有更多数据了");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  }),
          child:
          Obx(() => fragmentLogic.hasInit ? TabPage() : WelcomePage()),
        );
      }),
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
