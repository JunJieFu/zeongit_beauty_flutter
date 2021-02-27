import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/constant/key.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/user_info_entity_helper.dart';
import 'package:zeongitbeautyflutter/pages/tab.page.dart';
import 'package:zeongitbeautyflutter/pages/welcome.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/util/permission.util.dart';
import 'package:zeongitbeautyflutter/plugins/util/storage.util.dart';
import 'package:zeongitbeautyflutter/provider/fragment.provider.dart';
import 'package:zeongitbeautyflutter/provider/tag.provider.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/simple_bloc_observer.dart';

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
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
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
        child: MaterialApp(
          theme: ThemeData(
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
        ));
  }
}
