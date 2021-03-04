import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';

class EditPage extends StatefulWidget {
  EditPage(this.picture, {Key key,@required this.callback}) : super(key: key);

  final PictureEntity picture;

  final void Function(PictureEntity) callback;

  @override
  EditPageState createState() => EditPageState(picture);
}

class EditPageState extends State<EditPage> {
  EditPageState(this.picture);

  PictureEntity picture;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("编辑"),
        ),
        body: Container());
  }
}
