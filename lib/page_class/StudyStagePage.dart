import 'package:flutter/material.dart';

// 단어 공부 페이지

class StudyStagePage extends StatefulWidget {
  @override
  _StudyStagePageState createState() => _StudyStagePageState();
}

class _StudyStagePageState extends State<StudyStagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: 뒤로가기 버튼 추가하기

      body: Row(
        children: <Widget>[
        //TODO: 단계별 입장 버튼 추가하기
          stage_button[0],
          stage_button[0]
        ],),
      
      //TODO: 페이지 넘김 버튼 추가하기
    );
  }
}

List<Widget> stage_button = [
  ReusableCard()
];

class ReusableCard extends StatelessWidget {

  ReusableCard({this.cardChild, this.round});

  final Widget cardChild; //눌렀을 때 전환될 페이지
  final int round;        //현재 몇단계인지, TODO: 반복문으로 해결해보자
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //TODO: 원 모양 버튼으로 변경하기
          //TODO: 별 획득 갯수도 나타내보자
          FloatingActionButton(
            onPressed: (){
              print(round); //버튼이 잘 클릭되는지 확인
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
              '$round단계',
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
        color: Colors.purple,
      ),
    );
  }
}

