import 'package:flutter/cupertino.dart';
import 'package:zeongitbeautyflutter/plugins/constants/key.constant.dart';
import 'package:zeongitbeautyflutter/plugins/utils/storage.util.dart';

class FragmentState extends ChangeNotifier {
  bool _hadInit;

  bool get hadInit => _hadInit;

  FragmentState({bool hadInit}) {
    this._hadInit = hadInit;
  }

  updateHadInit() {
    StorageManager.setBool(KeyConstant.HAD_INIT, true);
    this._hadInit = true;
    notifyListeners();
  }
}
