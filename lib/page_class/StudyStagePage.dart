import 'package:flutter/material.dart';
import 'package:learn_korean_for_children/page_class/StudyDictation.dart';

String img_path = 'images/StudyStagePage';
// 단어 공부 페이지
class StudyStagePage extends StatefulWidget {
  @override
  _StudyStagePageState createState() => _StudyStagePageState();
}

class _StudyStagePageState extends State<StudyStagePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        //스테이지 버튼
        body: Row(
          children: [
            //뒤로가기 버튼
            Column(
              children: [
                BackPage(context),
                SizedBox(height: 200,)
              ],
            ),
            //스테이지 버튼
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //위에 세줄
                    Row(
                      children: <Widget>[
                        stage_button[0],
                        stage_button[1],
                        stage_button[2]
                      ],),

                    //아래 세줄
                    Row(
                      children: <Widget>[
                        stage_button[3],
                        stage_button[4],
                        stage_button[5]
                      ],),
                  ],
                ),

                // 다음 페이지로 넘기기 버튼
                PassStep[0]
              ],
            ),
          ],
        ),
       
      ),
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

Widget BackPage(BuildContext context){
  return InkWell(
  child: Image.asset('$img_path/back_page_blue.png',width: 120, height: 120),
  onTap: () => Navigator.pop(context)
  );
}

List<Widget> PassStep = [
  InkWell(
  child: Image.asset('$img_path/step_next.png',width: 120, height: 120),
  onTap: () {}//TODO: 다음 페이지로 넘기기
  )

];

class ReusableCard extends StatelessWidget {

  ReusableCard({this.cardChild, this.round,});
  //TODO: 문제 저장 클래스, 점수 저장 클래스와 연동시켜야 한다.

  final Widget cardChild; //눌렀을 때 전환될 페이지 TODO: 널 페이지 반환 해결하기
  final int round;        //현재 몇단계인지, TODO: 반복문으로 해결해보자
  final int star_score = 1;

  
  void add_star(List list){
    for(int i = 0; i < star_score; i++)
      list.add(Icon(
            Icons.star,
            color: Colors.yellow,
            ),
          );
    for(int i = star_score; i < 3 ; i++)
      list.add(Icon(
            Icons.star,
            color: Colors.blueGrey,
            ),
          );
  }
  Widget addButton(BuildContext context){
    return InkWell(
            child: Image.asset('$img_path/stage_background.png', width: 100, height: 80,),
            onTap: () => Navigator.push(context, 
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return cardChild;
                  }
                )
              )
          );
  }
  Widget addText(BuildContext context){
    return InkWell( 
      child: Text(
                  '\n   \t$round단계',
                  style: TextStyle(fontSize: 20.0),
                  ),
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
    List<Widget> star = new List<Widget>();
    add_star(star);
    
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Row(
              children: star,
            ),
            Stack(
              children: <Widget>[
                addButton(context),
                addText(context),
                
              ]
            ),
        ],
        
      ),
      
      margin: EdgeInsets.all(30.0),
      
    );
  }
}

