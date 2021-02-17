import 'package:flutter/material.dart';
import 'package:learn_korean_for_children/controllor/wrong_problem_controllor.dart';
import 'package:learn_korean_for_children/data/problemData.dart';
import 'package:learn_korean_for_children/model/ProblemModel.dart';
import 'package:learn_korean_for_children/page_class/StudyDictation.dart';

String imgPath = 'images/StudyStagePage';

//TODO: 충돌을 수정한 부분에서 문제가 없는지 확인하자.
// 단어 공부 페이지
class StudyStagePage extends StatefulWidget {
  @override
  _StudyStagePageState createState() => _StudyStagePageState();
}

class _StudyStagePageState extends State<StudyStagePage> {
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
    stageButtonList.add(
      ReusableCard(
        round: '오늘의 문제',
        cardChild: StudyDictation(0),
      ),
    );
    problemData.forEach((key, value) {
      stageButtonList.add(
        ReusableCard(
          round: key,
          cardChild: StudyDictation(key),
        ),
      );
    });
    super.initState();
  }

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

class ReusableCard extends StatefulWidget {
  ReusableCard({
    this.cardChild,
    this.round,
  });

  final Widget cardChild; //눌렀을 때 전환될 페이지
  final dynamic round;
  @override
  _ReusableCardState createState() => _ReusableCardState();
}

class _ReusableCardState extends State<ReusableCard> {
  int starScore = 1;

  List<ProblemModel> problems = [];

  @override
  void initState() {
    if (!(widget.round is String))
      WrongProblemControllor()
        ..loadSqlite(widget.round).then((value) => problems = value);

    int wrongScore = problems.length;
    if (wrongScore < 1)
      starScore = 3;
    else if (wrongScore < 5)
      starScore = 2;
    else if (wrongScore < 8)
      starScore = 1;
    else
      starScore = 0;
  }

  void addStar(List list) {
    for (int i = 0; i < starScore; i++)
      list.add(
        Icon(
          Icons.star,
          color: (i < starScore) ? Colors.yellow : Colors.blueGrey,
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
              widget.round is String
                  ? '\n\t${widget.round}'
                  : '\n    \t${widget.round}단계',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
        onTap: () => Navigator.push(context,
                MaterialPageRoute<void>(builder: (BuildContext context) {
              return widget.cardChild;
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
            addText(context),
          ]),
        ],
      ),
      margin: EdgeInsets.all(30.0),
    );
  }
}
