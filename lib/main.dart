import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/user_info_entity_helper.dart';
import 'package:zeongitbeautyflutter/pages/home/tab.page.dart';
import 'package:zeongitbeautyflutter/pages/welcome.page.dart';
import 'package:zeongitbeautyflutter/plugins/constants/key.constant.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/permission.util.dart';
import 'package:zeongitbeautyflutter/plugins/utils/storage.util.dart';
import 'package:zeongitbeautyflutter/provider/fragment.provider.dart';
import 'package:zeongitbeautyflutter/provider/tag.provider.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
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
    var hasInit = StorageManager.get(KeyConstant.HAD_INIT) ?? false;

    var info = StorageManager.getJson(KeyConstant.USER_INFO) != null
        ? userInfoEntityFromJson(
            UserInfoEntity(), StorageManager.getJson(KeyConstant.USER_INFO))
        : null;
    var themeData = ThemeData();

    var chipTheme = themeData.chipTheme;

    /// 在异步操作时,显示的页面
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => FragmentState(hadInit: hasInit)),
          ChangeNotifierProvider(create: (context) => TagState()),
          ChangeNotifierProvider(create: (context) => UserState(info: info))
        ],
        child: RefreshConfiguration(
          headerBuilder: () => MaterialClassicHeader(
            color: StyleConfig.primaryColor,
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
          child: MaterialApp(
            routes: routes,
            theme: ThemeData(
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.white,
                    foregroundColor: StyleConfig.primaryColor,
                    elevation: 6,
                    highlightElevation: 6),
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        primary: StyleConfig.primaryColor)),
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                  primary: StyleConfig.primaryColor,
                )),
                outlinedButtonTheme: OutlinedButtonThemeData(
                    style: OutlinedButton.styleFrom(
                        primary: StyleConfig.primaryColor,
                        side: BorderSide(color: StyleConfig.primaryColor))),
                chipTheme: ChipThemeData(
                    backgroundColor: chipTheme.backgroundColor,
                    disabledColor: chipTheme.disabledColor,
                    selectedColor: chipTheme.selectedColor,
                    secondarySelectedColor: chipTheme.secondarySelectedColor,
                    labelPadding: chipTheme.labelPadding,
                    padding: chipTheme.padding,
                    shape: chipTheme.shape,
                    labelStyle: chipTheme.labelStyle,
                    secondaryLabelStyle: chipTheme.secondaryLabelStyle,
                    brightness: chipTheme.brightness,
                    elevation: 0,
                    pressElevation: 0),
                platform: TargetPlatform.android,
                scaffoldBackgroundColor: Colors.white,
                primaryColor: Colors.white,
                primaryColorBrightness: Brightness.light,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                appBarTheme: AppBarTheme(elevation: 1),
                tabBarTheme: TabBarTheme(
                  labelColor: StyleConfig.primaryColor,
                  unselectedLabelColor: Colors.black45,
                )),
            home: hasInit ? TabPage() : WelcomePage(),
            localizationsDelegates: [
              // ... app-specific localization delegate[s] here
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: Platform.isIOS ? ios : an,
            locale: Locale('zh'),
          ),
        ));
  }
}
