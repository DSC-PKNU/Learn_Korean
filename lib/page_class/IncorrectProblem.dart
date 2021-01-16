import 'package:flutter/material.dart';
import 'package:learn_korean_for_children/controllor/wrong_problem_controllor.dart';
import 'package:learn_korean_for_children/data/problemData.dart';
import 'package:learn_korean_for_children/page_class/StudyDictation.dart';
import 'IncorrectProblemForParent.dart';

String imgPath = 'images/IncorrectProblem'; //TODO: 이미지 경로 설정

// 맞춤법
class IncorrectProblem extends StatefulWidget {
  @override
  _IncorrectProblemState createState() => _IncorrectProblemState();
}

class _IncorrectProblemState extends State<IncorrectProblem> {
  int pageIndex = 0;
  List<Widget> stageButtonList = [];

  Widget stageButton(int index) {
    if (index + pageIndex * 6 < stageButtonList.length)
      return stageButtonList[index + pageIndex * 6];
    else
      return SizedBox();
  }

  Widget backPage(BuildContext context) {
    return InkWell(
        child:
            Image.asset('$imgPath/back_page_blue.png', width: 120, height: 120),
        onTap: () {
          if (pageIndex == 0) {
            Navigator.pop(context);
          } else {
            setState(() {
              pageIndex--;
            });
          }
        });
  }

  Widget passStep() => stageButtonList.length > (pageIndex + 1) * 6
      ? InkWell(
          child: Image.asset('$imgPath/step_next.png', width: 120, height: 120),
          onTap: () {
            setState(() {
              pageIndex++;
            });
          })
      : SizedBox();
  @override
  void initState() {
    create();
    super.initState();
  }

  create() async {
    stageButtonList.clear();
    await WrongProblemControllor().loadSqlite(0).then((result) {
      stageButtonList.add(
        ReusableCard(
            round: '오늘의 문제',
            wrongLength: result.length,
            cardChild: StudyDictation(0, wrongProblemMode: true),
            reload: create),
      );
    });

    problemData.forEach((key, value) async {
      await WrongProblemControllor().loadSqlite(key).then((result) {
        if (result.length != 0)
          stageButtonList.add(
            ReusableCard(
                round: key,
                wrongLength: result.length,
                cardChild: StudyDictation(key, wrongProblemMode: true),
                reload: create),
          );
        setState(() {});
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return stageButtonList.length == 0
        ? SafeArea(
            child: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('틀린 문제가 없습니다.'),
                    RaisedButton(
                      child: Text('뒤로가기'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        : SafeArea(
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
                              stageButton(0),
                              stageButton(1),
                              stageButton(2),
                            ],
                          ),

                          //아래 세줄
                          Row(
                            children: <Widget>[
                              stageButton(3),
                              stageButton(4),
                              stageButton(5),
                            ],
                          ),
                        ],
                      ),

                      // 다음 페이지로 넘기기 버튼
                      passStep()
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}

class ReusableCard extends StatelessWidget {
  ReusableCard({this.cardChild, this.wrongLength = 0, this.round, this.reload});
  //TODO: 문제 저장 클래스, 점수 저장 클래스와 연동시켜야 한다.
  final int wrongLength;
  final Function reload;
  final Widget cardChild; //눌렀을 때 전환될 페이지 TODO: 널 페이지 반환 해결하기
  final dynamic round; //현재 몇단계인지, TODO: 반복문으로 해결해보자
  final int starScore = 1; //TODO: 별을 받은 갯수 변수로 받기
  final int score = 7; //TODO: 맞춘 문제 갯수 변수로 받기
  final int problemNum = 10; //TODO: 총 문제 갯수?
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

  Widget addText(BuildContext context) {
    return InkWell(
        child: Stack(
          children: [
            Image.asset(
              '$imgPath/stage_background.png',
              width: 100,
              height: 80,
            ),
            Text(
              round is String
                  ? '\n\t$round\n     $wrongLength'
                  : '\n    \t$round단계\n     $wrongLength',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
        onTap: () => Navigator.push(context,
                MaterialPageRoute<void>(builder: (BuildContext context) {
              return cardChild;
            })).then((value) {
              reload();
            }));
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
            addText(context),
          ]),
        ],
      ),
      margin: EdgeInsets.all(30.0),
    );
  }
}
