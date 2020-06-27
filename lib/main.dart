import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/constant/key.constant.dart';
import 'package:zeongitbeautyflutter/assets/util/storage.util.dart';
import 'package:zeongitbeautyflutter/pages/home.page.dart';
import 'package:zeongitbeautyflutter/pages/tab.page.dart';
import 'package:zeongitbeautyflutter/pages/welcome.page.dart';
import 'package:zeongitbeautyflutter/provider/fragment.provider.dart';
import 'package:zeongitbeautyflutter/provider/tag.provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _init();
}

_init() async {
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

    /// 在异步操作时,显示的页面
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => FragmentState(hadInit: _hasInit)),
          ChangeNotifierProvider(create: (context) => TagState()),
        ],
        child: MaterialApp(
            theme: ThemeData(
              platform: TargetPlatform.fuchsia,
              scaffoldBackgroundColor: Colors.white,
              primaryColor: Colors.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: _hasInit ? TabPage() : WelcomePage()));
  }
}
