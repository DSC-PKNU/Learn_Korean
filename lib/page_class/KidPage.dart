import 'package:flutter/material.dart';
import 'StudyPage.dart';

// 첫 시작 페이지 : 아이 계정
//TODO: 보호자 계정 전환버튼 추가
//TODO: 정확한 색깔 배정
//TODO: 각 버튼 크기, 위치 조정
//TODO: 버튼 디자인 수정

//글자가 길면 세로모드에서 깨짐 ex) 받아쓰기 연습


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
          kid_page_card[0], 
          //오른쪽 줄
          kid_page_card[1],
        ],),
      
    );
  }
}

List<Widget> kid_page_card= [
  //왼쪽 줄
  Expanded(child: Column(
            children: <Widget>[
              //공부 시작
              Expanded(child: ReusableCard(
                  colour: Colors.yellow,
                  text: "공부 시작"
                  ),
              ),
              //받아쓰기 연습
              Expanded(child: ReusableCard(
                  colour: Colors.green,
                  text: "받아쓰기 연습",
                ),
              ),
              //맞춤법 공부
              Expanded(child: ReusableCard(
                colour: Colors.green,
                text: "맞춤법 공부",
                ),
              ),
            ],),
          ),

          //두번째 줄
          Expanded(child: Column(
            children: <Widget>[
              //틀린 문제
              Expanded(
                child: ReusableCard(
                  colour: Colors.red,
                  text: '틀린 문제',
                ),
              ),
              //칭찬판
              Expanded(
                child: ReusableCard(
                  colour: Colors.red,
                  text: '칭찬판'
                ),
              ),
            ],
          )),
          ];

class ReusableCard extends StatelessWidget {

  ReusableCard({@required this.colour,  this.cardChild, this.text});

  final Color colour;
  final Widget cardChild;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton(
            onPressed: (){
              print(text);
            },
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20.0
              ),
            ),
          )
        ]
      ),
      margin: EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: colour,

      ),
    );
  }
}
