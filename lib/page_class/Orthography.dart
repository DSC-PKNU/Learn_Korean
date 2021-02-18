//맞춤법 심화 학습

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_korean_for_children/controllor/problem_orthography.dart';
import 'package:learn_korean_for_children/data/orthographyData.dart';
import 'package:learn_korean_for_children/model/OrthographyModel.dart';
import 'package:learn_korean_for_children/page_class/IncorrectProblem.dart';

// 맞춤법 문제가 음성으로 출제되고, 고르는 화면
String imgPath = 'images/Orthography';

class Orthography extends StatefulWidget {
  @override
  _OrthographyState createState() => _OrthographyState();
}

class _OrthographyState extends State<Orthography> {
  int problemIndex = 0; //문제 번호
  int stageAllocationCount = 10; //총 문제 수
  int rand = Random().nextInt(2); //문제를 섞기 위한 난수
  List<OrthographyModel> problems = []; //양자택일 정답 리스트
  List<OrthographyModel> incorrectProblems = []; //양자택일 오답 리스트
  List<List<String>> stageProblemList = []; //sqlite에서 얻어온 문제 리스트

  @override
  void initState() {
    //문제를 모두 불러온다.
    for (int i = 1; i < 20; i++) stageProblemList.add(orthographyData[i]);
    stageProblemList.shuffle(); //문제를 섞는다.

    // 양자 택일 리스트 생성
    for (int i = 0; i < stageAllocationCount; i++) {
      problems.add(OrthographyModel(problem: stageProblemList[i][0]));
      incorrectProblems.add(OrthographyModel(problem: stageProblemList[i][1]));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // 배경 사진
        decoration: boxDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: [
                          //첫 줄 : 홈버튼, 문제번호, 설정
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              homeButton(),
                              stageTitle(),
                            ],
                          ),

                          //둘째 줄 : 이전문제, 문제 칠판, 다음문제
                          Stack(alignment: Alignment.center, children: [
                            Image.asset(
                              '$imgPath/main.png',
                              width: 500,
                              height: 300,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //TODO: 이전 문제
                                //문제 칠판
                                Stack(
                                  children: [
                                    Column(
                                      children: [
                                        //TODO: 문제 이미지
                                        question(),
                                        //양자 택일 체크
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            selectAns()[rand],
                                            SizedBox(width: 60),
                                            selectAns()[1 - rand]
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                //TODO: 다음 문제
                              ],
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }

  Stack stageTitle() => Stack(alignment: Alignment.center, children: [
        Image(
          width: 700, //TODO : 좌우로 깨지지  않게
          image: AssetImage('$imgPath/stage.png'),
        ),
        Center(
          child: Column(
            children: [
              Text(
                'STAGE ${problemIndex + 1}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontStyle: FontStyle.normal),
              ),
            ],
          ),
        ),
      ]);

  BoxDecoration boxDecoration() => BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(
          "$imgPath/background.png",
        ),
      ));
  Widget homeButton() => Expanded(
        child: IconButton(
            icon: Icon(Icons.home),
            color: Colors.grey,
            iconSize: 50,
            onPressed: () => Navigator.of(context).pop()),
      );
  List<Widget> passProblem() => [
        problemIndex != 0
            ? InkWell(
                child: Image.asset(
                  '$imgPath/prev_problem.png',
                  width: 200,
                  height: 200,
                ),
                onTap: () {
                  setState(() {
                    problemIndex--;
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
                  '$imgPath/next_problem.png',
                  width: 150,
                  height: 150,
                ),
                onTap: () {
                  setState(() {
                    problemIndex++;
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

  List<Widget> selectAns() => [
        // 문제 출제
        InkWell(
          onTap: () {
            setState(() {
              rand = Random().nextInt(2);
              problemIndex++;
              //TODO: 정답처리
            });
          },
          child: SizedBox(
            width: 200,
            height: 100,
            child: Stack(alignment: Alignment.center, children: [
              Image(
                image: AssetImage('$imgPath/ans.png'),
              ),
              Text(
                problems[problemIndex].problem,
                style: TextStyle(fontSize: 25),
              ),
            ]),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              rand = new Random().nextInt(2);
              print(rand);
              problemIndex++;
              //TODO: 오답처리
            });
          },
          child: SizedBox(
            width: 200,
            height: 100,
            child: Stack(alignment: Alignment.center, children: [
              Image(
                image: AssetImage('$imgPath/ans.png'),
              ),
              Text(
                incorrectProblems[problemIndex].problem,
                style: TextStyle(fontSize: 25),
              ),
            ]),
          ),
        ),
      ];
  Widget question() => Image.asset(
        '$imgPath/sand.png',
        width: 100,
        height: 100,
      );
}

Widget exitButton(context) => InkWell(
    child: Image.asset(
      '$imgPath/exit_button.png',
      width: 150,
      height: 100,
    ),
    onTap: () => Navigator.pop(context));
