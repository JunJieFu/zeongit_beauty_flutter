import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

useFocusNodeObs(Rx<bool> focus) {
  final focusNode = FocusNode();
  useEffect(() {
    focusNode.addListener(() {
      focus.value = focusNode.hasFocus;
    });
    return () {
      focusNode.dispose();
    };
  }, const []);
  return focusNode;
}
