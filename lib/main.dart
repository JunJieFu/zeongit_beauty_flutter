import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/constant/key.constant.dart';
import 'package:zeongitbeautyflutter/assets/util/storage.util.dart';
import 'package:zeongitbeautyflutter/pages/tab.page.dart';
import 'package:zeongitbeautyflutter/pages/welcome.page.dart';
import 'package:zeongitbeautyflutter/provider/fragment.provider.dart';
import 'package:zeongitbeautyflutter/provider/tag.provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _init();
}

_init() async {
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  await StorageManager.init();
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var _hasInit = StorageManager.get(KeyConstant.HAD_INIT) ?? false;

    var themeData = ThemeData();

    var chipTheme = themeData.chipTheme;

    /// 在异步操作时,显示的页面
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => FragmentState(hadInit: _hasInit)),
          ChangeNotifierProvider(create: (context) => TagState()),
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
                buttonTheme: ButtonThemeData(
                    buttonColor: Colors.blue,
                    textTheme: ButtonTextTheme.primary),
                platform: TargetPlatform.android,
                scaffoldBackgroundColor: Colors.white,
                primaryColor: Colors.white,
                primaryColorBrightness: Brightness.light,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                appBarTheme: AppBarTheme(
                  elevation: 1
                ),
                tabBarTheme: TabBarTheme(
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.black45,
                )),
            home: _hasInit ? TabPage() : WelcomePage()));
  }
}
