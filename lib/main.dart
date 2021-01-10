import 'package:flutter/material.dart';
import 'page_class/KidPage.dart';
import 'package:flutter/services.dart';  //화면 고정을 위한 라이브러리
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //화면 고정하기
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft, 
      DeviceOrientation.landscapeRight
      ]);
    return MaterialApp(
      //아이계정으로 시작
      home: KidPage(),
    );
  }
}