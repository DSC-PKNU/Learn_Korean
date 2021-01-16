//보호자 계정에서의 틀린 문제 기록판
import 'package:flutter/material.dart';

String imgPath = ''; //아이의 답을 저장한 폴더

class IncorrectProblemForParents extends StatelessWidget {
  IncorrectProblemForParents(this.stageIndex);
  final int stageIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            //뒤로가기 버튼

            //푼 문제 리스트(스크롤 가능)
            ListView(children: <Widget>[
          problem[0],
          problem[1],
          problem[2],
          problem[3],
          problem[4],
          problem[5],
          problem[6],
          problem[7],
          problem[8],
          problem[9],
        ]),
      ),
    );
  }
}

//TODO: 문제 리스트에 넣을 매개변수 지정
List<Widget> problem = [
  ReusableCard(
    problemNum: 1,
    correctAns: '의자',
    ox: true,
  ),
  ReusableCard(
    problemNum: 2,
    correctAns: '모레',
    ox: false,
  ),
  ReusableCard(
    problemNum: 3,
    correctAns: '정답',
    ox: false,
  ),
  ReusableCard(
    problemNum: 4,
    correctAns: '정답',
    ox: true,
  ),
  ReusableCard(
    problemNum: 5,
    correctAns: '정답',
    ox: true,
  ),
  ReusableCard(
    problemNum: 6,
    correctAns: '정답',
    ox: true,
  ),
  ReusableCard(
    problemNum: 7,
    correctAns: '정답',
    ox: true,
  ),
  ReusableCard(
    problemNum: 8,
    correctAns: '정답',
    ox: true,
  ),
  ReusableCard(
    problemNum: 9,
    correctAns: '정답',
    ox: true,
  ),
  ReusableCard(
    problemNum: 10,
    correctAns: '정답',
    ox: true,
  ),
];

//TODO: 문제 리스트 재활용 구현
class ReusableCard extends StatelessWidget {
  ReusableCard(
      {this.problemNum,
      this.correctAns,
      // this.kidAns,
      this.ox,
      this.problemSound});

  //문제번호, 정답, 아이의 답, 채점 결과, 문제 음성
  final int problemNum;
  final String correctAns;
  final Widget kidAns = Text('아이의 답'); //TODO: 아이의 답
  final bool ox;
  final Widget problemSound; //TODO: 문제 음성 재생을 선언만 해두었다.

  addOx() {
    if (ox == true)
      return Text('O');
    else
      return Text('X');
  }

  //아이의 답 이미지 추가
  Widget addKidsAns() {
    return InkWell(
        //TODO: 버튼 이미지 할당
        child: Image.asset('images/StudyStagePage/stage_background.png',
            width: 300, height: 200),
        onTap: () => problemSound //TODO: 문제 음성 재생

        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Text(correctAns),
        addKidsAns(), //클릭하면 들을 수 있다.
        addOx(), //ox 여부에 따라 O와 X 아이콘 보여줌
      ]),
    );
  }
}
