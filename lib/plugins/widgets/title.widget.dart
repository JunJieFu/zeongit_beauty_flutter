import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  TitleWidget(
    this.text, {
    Key key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.headline6);
  }
}
