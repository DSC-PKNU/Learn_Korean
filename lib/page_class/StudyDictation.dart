import 'package:flutter/material.dart';
import 'package:learn_korean_for_children/controllor/problem_regist_controllor.dart';
import 'package:learn_korean_for_children/controllor/wrong_problem_controllor.dart';
import 'package:learn_korean_for_children/data/problemData.dart';
import 'package:learn_korean_for_children/library/tts.dart';
import 'package:learn_korean_for_children/model/ProblemModel.dart';
import 'package:painter/painter.dart';
import 'package:collection/collection.dart';

// 단어 문제가 음성으로 출제되고, 받아쓰는 화면
String imgPath = 'images/StudyDictation';

class StudyDictation extends StatefulWidget {
  StudyDictation(this.stageIndex, {this.wrongProblemMode = false});
  final int stageIndex;
  final bool wrongProblemMode;
  @override
  _StudyDictationState createState() =>
      _StudyDictationState(this.stageIndex, this.wrongProblemMode);
}

class _StudyDictationState extends State<StudyDictation> {
  @override
  dispose() {
    ttsStop();
    super.dispose();
  }

  _StudyDictationState(this.stageIndex, this.wrongProblemMode);

  final bool wrongProblemMode;
  int stageIndex;
  int problemIndex = 0;
  int stageAllocationCount = 10; //각 스테이지에서 10개를 풀 수 있음
  int score = 10;
  List<ProblemModel> problems = [];

  @override
  void initState() {
    if (wrongProblemMode) {
      //오답노트 모드
      WrongProblemControllor()
        ..loadSqlite(stageIndex).then((value) {
          setState(() {
            problems = value;
            ttsSpeak(problems[problemIndex].problem);
          });
        });
    } else {
      if (stageIndex == 0) {
        ProblemRegistControllor()
          ..loadSqlite().then((value) {
            setState(() {
              problems = value;
              ttsSpeak(problems[problemIndex].problem);
            });
          });
      } else {
        List<String> stageProblemList = problemData[stageIndex];
        stageProblemList.shuffle(); //문제를 섞는다.

        for (int i = 0; i < stageAllocationCount; i++) {
          problems.add(ProblemModel(problem: stageProblemList[i]));
        }
        ttsSpeak(problems[problemIndex].problem);
      }
    }
    super.initState();
    //그림판 설정=============================================
    _controller = _newController();
  }

  //그림판을 위한 변수
  PainterController _controller;

  PainterController _newController() {
    PainterController controller = new PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.transparent;
    return controller;
  }

  //그림판=================================

  @override
  Widget build(BuildContext context) {
    return problems.length == 0
        ? SafeArea(
            child: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('저장된 문제가 없습니다.'),
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
            child: Container(
              decoration: dictationDeco(),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Column(
                              children: [
                                SizedBox(
                                  height: 150,
                                  width: 100,
                                  child: Text('${problemIndex + 1}번 문제'),
                                ),
                                passProblem()[0],
                              ],
                            ),
                            // 받아쓰는 곳

                            Stack(alignment: Alignment.center, children: [
                              Image.asset(
                                "$imgPath/painter.png",
                                width: 400,
                                height: 700,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //dictationQueue()
                                  Text(dictationQueue[problemIndex]),
                                  //받아쓸 그림판
                                  paintDictation(),
                                ],
                              ),
                            ]),

                            Column(
                              children: [
                                volumeIcon(),
                                //다음문제 가기 아이콘
                                passProblem()[1],
                              ],
                            ),
                          ]),
                    ),

                    //버튼
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //지우개
                        delButton(),
                        //undo
                        undoButton(),
                        //확인 아이콘
                        checkButton(),
                        exitButton(context),
                      ],
                    )
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.startTop,
                floatingActionButton: wrongProblemMode
                    ? IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          WrongProblemControllor()
                              .deleteSqlite(stageIndex, problems[problemIndex]);
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  '오답 ${problems[problemIndex].problem} 삭제 완료')));
                        },
                        iconSize: 50,
                      )
                    : SizedBox(),
              ),
            ),
          );
  }

  int i = 0;
  List<String> dictationQueue = ['', '', '', '', '', '', '', '', '', ''];
  String ocr(PictureDetails picture) => ('a'); //TODO: ocr 기능 구현
  // List<Future> dictationQueue;
  Future<void> savePng(PictureDetails picture) async {
    final imageFile = picture.toImage();
    Function eq = const ListEquality().equals;

    setState(() {
      _controller = _newController();
      dictationQueue[problemIndex] += ocr(picture);
      problems[problemIndex].isRightAnswer =
          eq(dictationQueue[problemIndex], problems[problemIndex].problem);
      // dictationQueue[problemIndex] += '$i';
    });
  }

  BoxDecoration dictationDeco() => BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(
          "$imgPath/background.png",
        ),
      ));

  BoxDecoration paintDeco() => BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(
          "$imgPath/painter.png",
        ),
      ));

  Widget paintDictation() => Expanded(
      child:
          SizedBox(height: 700, width: 400, child: new Painter(_controller)));

  double iconWidth = 150;
  double iconHeight = 70;
  Widget checkButton() => InkWell(
        child: Image.asset(
          '$imgPath/check.png',
          width: iconWidth,
          height: iconHeight,
        ),
        onTap: () => savePng(_controller.finish()),
      );
  Widget delButton() => InkWell(
      child: Image.asset(
        '$imgPath/del.png',
        width: iconWidth,
        height: iconHeight,
      ),
      onTap: _controller.clear);

  Widget undoButton() => InkWell(
        child: Image.asset(
          '$imgPath/undo.png',
          width: iconWidth,
          height: iconHeight,
        ),
        onTap: _controller.undo,
      );

  Widget exitButton(context) => InkWell(
        child: Image.asset(
          '$imgPath/exit.png',
          width: iconWidth,
          height: iconHeight,
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      );
  Widget volumeIcon() => InkWell(
        child: Image.asset(
          '$imgPath/volume.png',
          width: 150,
          height: 150,
        ),
        onTap: () {
          ttsSpeak(problems[problemIndex].problem);
        },
      );

  List<Widget> passProblem() => [
        problemIndex != 0
            ? InkWell(
                child: Image.asset(
                  '$imgPath/prev.png',
                  width: 150,
                  height: 100,
                ),
                onTap: () {
                  setState(() {
                    problemIndex--;
                    _controller = _newController();
                    ttsSpeak(problems[problemIndex].problem);
                  });
                },
              )
            : SizedBox(
                width: 150,
                height: 100,
              ),
        problemIndex != problems.length - 1
            ? InkWell(
                child: Image.asset(
                  '$imgPath/next.png',
                  width: 150,
                  height: 100,
                ),
                onTap: () {
                  setState(() {
                    problemIndex++;
                    _controller = _newController();
                    ttsSpeak(problems[problemIndex].problem);
                  });
                },
              )
            : InkWell(
                child: Image.asset(
                  '$imgPath/next_round.png',
                  width: 150,
                  height: 100,
                ),
                onTap: () {
                  int i = 0;
                  while (i < stageAllocationCount) {
                    if (!problems[problemIndex].isRightAnswer) {
                      WrongProblemControllor()
                          .saveSqlite(stageIndex, problems[problemIndex]);
                      score--;
                    }

                    i++;
                  }
                  Navigator.pop(context);
                },
              ),
      ];
}
