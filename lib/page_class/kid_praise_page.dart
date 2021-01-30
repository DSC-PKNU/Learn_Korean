import 'package:flutter/material.dart';

String imgPath = "images/KidPraise/";

class GetPraisePage extends StatefulWidget {
  @override
  _GetPraisePageState createState() => _GetPraisePageState();
}

class _GetPraisePageState extends State<GetPraisePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(imgPath + "praise_tree.png"),
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
      ),
    ));
  }
}
