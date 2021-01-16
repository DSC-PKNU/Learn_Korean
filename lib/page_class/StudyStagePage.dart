import 'package:flutter/material.dart';
import 'package:learn_korean_for_children/data/problemData.dart';
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

class ReusableCard extends StatelessWidget {
  ReusableCard({
    this.cardChild,
    this.round,
    //TODO: SQLite 저장
  });
  //TODO: 문제 저장 클래스, 점수 저장 클래스와 연동시켜야 한다.

  final Widget cardChild; //눌렀을 때 전환될 페이지 TODO: 널 페이지 반환 해결하기
  final dynamic round; //현재 몇단계인지, TODO: 반복문으로 해결해보자
  final int starScore = 1;

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
              round is String ? '\n\t$round' : '\n    \t$round단계',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
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
            addText(context),
          ]),
        ],
      ),
      margin: EdgeInsets.all(30.0),
    );
  }
}
