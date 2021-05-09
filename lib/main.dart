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
import 'package:zeongitbeautyflutter/provider/fragment.getx_ctrl.dart';
import 'package:zeongitbeautyflutter/provider/theme.getx_ctrl.dart';
import 'package:zeongitbeautyflutter/provider/user.getx_ctrl.dart';
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
    Get.lazyPut(() => ThemeGetxCtrl());
    Get.lazyPut(() => FragmentGetxCtrl());
    Get.lazyPut(() => UserGetxCtrl());
    final fragmentGetxCtrl = Get.find<FragmentGetxCtrl>();
    final themeGetxCtrl = Get.find<ThemeGetxCtrl>();

    /// 在异步操作时,显示的页面
    return Obx(
      () => GetMaterialApp(
        routes: routes,
        theme: themeGetxCtrl.isDark
            ? darkThemeData(themeGetxCtrl.primaryColor)
            : lightThemeData(themeGetxCtrl.primaryColor),
        home: Builder(builder: (ctx) {
          var primaryColor = Theme.of(ctx).primaryColor;
          return RefreshConfiguration(
            headerBuilder: () => MaterialClassicHeader(
              color: primaryColor,
              backgroundColor: themeGetxCtrl.isDark ? Theme.of(ctx).cardColor : Colors.white,
            ),
            footerBuilder: () =>
                CustomFooter(builder: (BuildContext context, LoadStatus mode) {
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
                Obx(() => fragmentGetxCtrl.hasInit ? TabPage() : WelcomePage()),
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
      ),
    );
  }
}
