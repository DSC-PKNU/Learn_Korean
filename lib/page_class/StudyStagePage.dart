import 'package:flutter/material.dart';
import 'package:learn_korean_for_children/page_class/StudyDictation.dart';

// 단어 공부 페이지
class StudyStagePage extends StatefulWidget {
  @override
  _StudyStagePageState createState() => _StudyStagePageState();
}

class _StudyStagePageState extends State<StudyStagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: 뒤로가기 버튼 디자인 수정하기
      //뒤로가기 버튼
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.keyboard_backspace
        ),
        onPressed: (){
          Navigator.pop(context);
        },
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      
      //스테이지 버튼
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //위에 세줄
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            //TODO: 단계별 입장 버튼 추가하기
              stage_button[0],
              stage_button[1],
              stage_button[2]
              
            ],),

          //아래 세줄
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              stage_button[3],
              stage_button[4],
              stage_button[5]
            ],),
        ],
      ),
      
      //TODO: 페이지 넘김 버튼 추가하기
     
    );
  }
}

List<Widget> stage_button = [
  ReusableCard(round: 1,cardChild: StudyDictation(),),
  ReusableCard(round: 2,cardChild: Text('test')),
  ReusableCard(round: 3,cardChild: Text('test')),
  ReusableCard(round: 4,cardChild: Text('test')),
  ReusableCard(round: 5,cardChild: Text('test')),
  ReusableCard(round: 6,cardChild: Text('test')),

];


class ReusableCard extends StatelessWidget {

  ReusableCard({this.cardChild, this.round});

  final Widget cardChild; //눌렀을 때 전환될 페이지
  final int round;        //현재 몇단계인지, TODO: 반복문으로 해결해보자
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //TODO: 버튼 디자인이 못생겼음, 동그랗지 않고 색도 바꿔야 한다.
          //TODO: 별 획득 갯수도 나타내보자
          FloatingActionButton.extended(
            
            heroTag: round,
            backgroundColor: Colors.purple,
            onPressed: (){
              //화면 전환
              Navigator.push(context, 
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return cardChild;
                  }
                )
              );
            },
            label: Text(
              '$round단계',
              style: TextStyle(
                fontSize: 20.0
              ),
            ),
          )
        ]
      ),
      margin: EdgeInsets.all(30.0),
      
    );
  }
}

