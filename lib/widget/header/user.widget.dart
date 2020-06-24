import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';

class UserWidget extends StatefulWidget {
  UserWidget({Key key}) : super(key: key);

  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  UserState userState;

  @override
  Widget build(BuildContext context) {
//    userState = Provider.of<UserState>(context, listen: false);
    return IconButton(
      padding: EdgeInsets.all(0),
      icon: Container(
        child: AspectRatio(
            aspectRatio: 1,
            child: ClipOval(
                child: Image(
                    image: AssetImage('assets/images/welcome.jpg'),
                    fit: BoxFit.cover))),
      ),
      onPressed: () {},
    );
  }
}
