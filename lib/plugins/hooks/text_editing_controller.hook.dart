import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

useTextEditingControllerObs(Rx<String> text) {
  final controller = TextEditingController(text: text.value);
  useEffect(() {
    controller.addListener(() {
      text.value = controller.text;
    });
    return () {
      controller.dispose();
    };
  }, const []);
  return controller;
}
