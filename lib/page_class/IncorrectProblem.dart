import 'package:flutter/material.dart';
import 'package:learn_korean_for_children/page_class/StudyDictation.dart';
import 'IncorrectProblemForParent.dart';
String imgPath = 'images/IncorrectProblem';

// 맞춤법
class IncorrectProblem extends StatefulWidget {
  @override
  _IncorrectProblemState createState() => _IncorrectProblemState();
}

class _IncorrectProblemState extends State<IncorrectProblem> {
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
                backPage(context),
                SizedBox(
                  height: 200,
                )
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
                        stageButton[0],
                        stageButton[1],
                        stageButton[2]
                      ],
                    ),

                    //아래 세줄
                    Row(
                      children: <Widget>[
                        stageButton[3],
                        stageButton[4],
                        stageButton[5]
                      ],
                    ),
                  ],
                ),

                // 다음 페이지로 넘기기 버튼
                passStep[0]
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> stageButton = [
  ReusableCard(round: 1,cardChild: IncorrectProblemForParents()),
  ReusableCard(round: 2, cardChild: IncorrectProblemForParents()),
  ReusableCard(round: 3, cardChild: IncorrectProblemForParents()),
  ReusableCard(round: 4, cardChild: IncorrectProblemForParents()),
  ReusableCard(round: 5, cardChild: IncorrectProblemForParents()),
  ReusableCard(round: 6, cardChild: IncorrectProblemForParents()),
];

Widget backPage(BuildContext context) {
  return InkWell(
      child:
          Image.asset('$imgPath/back_page_blue.png', width: 120, height: 120),
      onTap: () => Navigator.pop(context));
}

List<Widget> passStep = [
  InkWell(
      child: Image.asset('$imgPath/step_next.png', width: 120, height: 120),
      onTap: () {} //TODO: 다음 페이지로 넘기기
      )
];

class ReusableCard extends StatelessWidget {
  ReusableCard({
    this.cardChild,
    this.round,
  });
  //TODO: 문제 저장 클래스, 점수 저장 클래스와 연동시켜야 한다.

  final Widget cardChild;     //눌렀을 때 전환될 페이지 TODO: 널 페이지 반환 해결하기
  final int round;            //현재 몇단계인지, TODO: 반복문으로 해결해보자
  final int starScore = 1;    //TODO: 별을 받은 갯수 변수로 받기
  final int score = 7;        //TODO: 맞춘 문제 갯수 변수로 받기
  final int problemNum = 10;  //TODO: 총 문제 갯수?
  void addStar(List list) {
    for (int i = 0; i < starScore; i++)
      list.add(
        Icon(
          Icons.star,
          color: Colors.yellow,
        ),
      );
    for (int i = starScore; i < 3; i++)
      list.add(
        Icon(
          Icons.star,
          color: Colors.blueGrey,
        ),
      );
  }

  Widget addButton(BuildContext context) {
    return InkWell(
        child: Image.asset(
          '$imgPath/stage_background.png',
          width: 100,
          height: 80,
        ),
        onTap: () => Navigator.push(context,
                MaterialPageRoute<void>(builder: (BuildContext context) {
              return cardChild;
            })));
  }

  Widget addText(BuildContext context) {
    return InkWell(
        child: Text(
          '\n    \t$round단계\n     $score/$problemNum',
          style: TextStyle(fontSize: 20.0),
        ),
        onTap: () => Navigator.push(context,
                MaterialPageRoute<void>(builder: (BuildContext context) {
              return cardChild;
            })));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> star = new List<Widget>();
    addStar(star);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: star,
          ),
          Stack(children: <Widget>[
            addButton(context),
            addText(context),
          ]),
        ],
      ),
      margin: EdgeInsets.all(30.0),
    );
  }
}
