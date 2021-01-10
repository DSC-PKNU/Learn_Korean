import 'package:flutter/material.dart';
import 'StudyStagePage.dart';
import 'parent_page.dart';
import 'IncorrectProblem.dart';
import 'Othography.dart';
// 첫 시작 페이지 : 아이 계정

String img_path = 'images/KidPage';
class KidPage extends StatefulWidget {
  @override
  KidPage_State createState() => KidPage_State();
}

class KidPage_State extends State<KidPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            //왼쪽 줄 : 받아쓰기, 맞춤법 공부
            kid_page_card[0], 
            //오른쪽 줄 : 틀린 문제, 칭찬 모으기
            kid_page_card[1],
            //보호자 계정으로 전환 버튼
            ConvertToParents(context)
          ],
        ),
        
      ),
    );
  }
}

List<Widget> kid_page_card= [
  //왼쪽 줄
  Expanded(child: Column(
    children: <Widget>[
      //받아쓰기 연습
      Expanded(
        child: ReusableCard(
          text: "dictation",
          cardChild: StudyStagePage(),
        ),
      ),
      //맞춤법 공부
      Expanded(child: ReusableCard(
        text: "othography",
        cardChild: Orthography(),
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
          text: 'incorrect',
          //TODO: 틀린 문제 페이지 연결
          cardChild: IncorrectProblem(),
        ),
      ),
      //칭찬판
      Expanded(
        child: ReusableCard(
          text: 'praise',
          //TODO: 칭찬판 페이지 연결
          cardChild: Text('칭찬판 페이지'),
        ),
      ),
    ],
  )),
];

Widget ConvertToParents(BuildContext context){
  return InkWell(
  child: Image.asset('images/KidPage/convert_to_parent.png',width: 120, height: 120),
  onTap: () {
    Navigator.push(context, 
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return ParentPage();
          }
        )
      );
    }
  );
}
class ReusableCard extends StatelessWidget {

  ReusableCard({  
    this.cardChild, 
    @required this.text,
  });

  final Widget cardChild; //눌렀을 때 전환될 페이지
  final String text;      //버튼 위에 나타날 텍스트

  Widget addButton(BuildContext context){
    return InkWell(
            //TODO: 버튼 이미지 할당
            child: Image.asset('$img_path/$text.png', width: 300, height: 300),
            onTap: () => Navigator.push(context, 
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return cardChild;
                  }
                )
              )
          );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
           addButton(context)
        ]
      ),
    );
  }
}
