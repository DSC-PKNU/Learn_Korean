import 'package:flutter/material.dart';
import 'StudyStagePage.dart';

// 첫 시작 페이지 : 아이 계정

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
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: <Widget>[
          //왼쪽 줄 : 공부 시작, 받아쓰기 연습, 맞춤법 공부
          kid_page_card[0], 
          //오른쪽 줄 : 틀린 문제, 칭찬판
          kid_page_card[1],
          //TODO: 보호자 계정 전환 버튼 위치 변경
            FloatingActionButton.extended(
              label: Text('보호자\n 계정'),
              onPressed: null,//보호자 계정 전환
              backgroundColor: Colors.orange,
            )
        ],),
      
    );
  }
}

//TODO: Expanded 위젯 말고 다른 위젯을 쓰는게 좋을 지도 모른다.
List<Widget> kid_page_card= [
  //왼쪽 줄
  Expanded(child: Column(
    children: <Widget>[
      //공부 시작
      Expanded(child: ReusableCard(
          colour: Colors.yellow,
          text: "공부 시작",
          ),
      ),
      //받아쓰기 연습
      Expanded(
        child: ReusableCard(
          colour: Colors.green,
          text: "받아쓰기 연습",
          cardChild: StudyStagePage(),
        ),
      ),
      //맞춤법 공부
      Expanded(child: ReusableCard(
        colour: Colors.green,
        text: "맞춤법 공부",
        //TODO: 맞춤법 공부 페이지 연결
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
          //TODO: 틀린 문제 페이지 연결
        ),
      ),
      //칭찬판
      Expanded(
        child: ReusableCard(
          colour: Colors.red,
          text: '칭찬판',
          //TODO: 칭찬판 페이지 연결
        ),
      ),
    ],
  )),
];

class ReusableCard extends StatelessWidget {

  ReusableCard({@required this.colour,  this.cardChild, @required this.text});

  final Color colour;     //버튼 색깔
  final Widget cardChild; //눌렀을 때 전환될 페이지
  final String text;      //버튼 위에 나타날 텍스트
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //TODO: 버튼 디자인 수정, (색깔, 크기맞춤)
          FlatButton(
            onPressed: (){
              print(text); //버튼이 잘 클릭되는지 확인 TODO: 제거하기
              //화면 push
              Navigator.push(context, 
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return cardChild;
                  }
                )
              );
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
      //TODO: 이미지를 덮어씌우던가 디자인 변경하자
      decoration: BoxDecoration(
        //image: ,
        borderRadius: BorderRadius.circular(50.0),
        color: colour,

      ),
    );
  }
}
