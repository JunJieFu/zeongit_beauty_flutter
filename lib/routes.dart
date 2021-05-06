import 'package:zeongitbeautyflutter/pages/account/sign_in.page.dart';

class RoutesKey {
  static const String SIGN_IN = "/signIn";
}

// 由于后退用到，所以写了个具名路由
final routes = {
  RoutesKey.SIGN_IN: (context) => SignInPage(),
};
