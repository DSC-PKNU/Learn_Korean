import 'package:flutter/material.dart';
// 첫 시작 페이지 : 아이 계정
class KidPage extends StatefulWidget {
  @override
  KidPage_State createState() => KidPage_State();
}

class KidPage_State extends State<KidPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          //왼쪽 줄
          Expanded(child: Column(
            children: <Widget>[
              ReusableCard(colour: Colors.yellow,
              text: '공부 시작',),
            ],),
          ),
          //오른쪽 줄
          Expanded(child: Column(
            children: <Widget>[
              ReusableCard(colour: Colors.red,
              text: '틀린 문제',),
            ],
          )),
        ],),
      
    );
  }
}
class ReusableCard extends StatelessWidget {

  ReusableCard({@required this.colour,  this.cardChild, this.text});

  final Color colour;
  final Widget cardChild;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text),
      margin: EdgeInsets.all(100.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: colour,

      ),
    );
  }
}
