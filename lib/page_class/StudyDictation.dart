import 'package:flutter/material.dart';
import 'package:learn_korean_for_children/controllor/problem_regist_controllor.dart';
import 'package:learn_korean_for_children/controllor/wrong_problem_controllor.dart';
import 'package:learn_korean_for_children/data/problemData.dart';
import 'package:learn_korean_for_children/library/tts.dart';
import 'package:learn_korean_for_children/model/ProblemModel.dart';
import 'package:painter/painter.dart';
import 'package:tesseract_ocr/tesseract_ocr.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import 'dart:io';

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
    // _finished = false;
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Expanded(
                      child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Column(
                              children: [
                                SizedBox(
                                  height: 50,
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
                                height: 400,
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
                            //FIXME: 임시로 만들어둔 버튼
                            // Row(
                            //   children: [
                            //     RaisedButton(
                            //       child: Text('정답'),
                            //       onPressed: () {
                            //         // ScaffoldMessenger.of(context)
                            //         //     .showSnackBar(SnackBar(
                            //         //   content: Text('정답'),
                            //         // ));
                            //       },
                            //     ),
                            //     RaisedButton(
                            //       child: Text('오답'),
                            //       onPressed: () {
                            //         WrongProblemControllor().saveSqlite(
                            //             stageIndex, problems[problemIndex]);
                            //         // ScaffoldMessenger.of(context)
                            //         //     .showSnackBar(SnackBar(
                            //         //   content: Text(
                            //         //       '오답 ${problems[problemIndex].problem} 문제'),
                            //         // ));
                            //       },
                            //     )
                            //   ],
                            // ),
                          ]),
                    ),

                    //버튼
                    Expanded(
                      child: Row(
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
                      ),
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

//TODO: 이미지 저장해서 글자인식이랑 주고받기
  int i = 0;
  List<String> dictationQueue = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j'
  ];

  // List<Future> dictationQueue;
  Future<void> savePng(PictureDetails picture) async {
    final imageFile = picture.toImage();

    setState(() {
      _controller = _newController();
      //1. picture를 이미지로 변환
      //2. ocr로 텍스트로 변환
      //3. dictationQueue에 저장
      //4. dictationQueue를 채점
    });

    // dictationQueue[problemIndex] += '$i';
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

//TODO: 아이콘 예쁘게 변경
  double iconWidth = 150;
  double iconHeight = 150;
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
          width: 100,
          height: 50,
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
                  width: 200,
                  height: 200,
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
                width: 200,
                height: 200,
              ),
        problemIndex != problems.length - 1
            ? InkWell(
                child: Image.asset(
                  '$imgPath/next.png',
                  width: 200,
                  height: 200,
                ),
                onTap: () {
                  setState(() {
                    problemIndex++;
                    _controller = _newController();
                    ttsSpeak(problems[problemIndex].problem);
                  });
                },
              )
            : RaisedButton(
                child: Text('StageClear!'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
      ];
}
