//보호자 계정에서의 틀린 문제 기록판
import 'package:flutter/material.dart';

String img_path = ''; //아이의 답을 저장한 폴더

class IncorrectProblemForParents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            //뒤로가기 버튼

            //푼 문제 리스트(스크롤 가능)
            ListView(children: <Widget>[
          Problem[0],
          Problem[1],
          Problem[2],
          Problem[3],
          Problem[4],
          Problem[5],
          Problem[6],
          Problem[7],
          Problem[8],
          Problem[9],
        ]),
      ),
    );
  }
}

//TODO: 문제 리스트에 넣을 매개변수 지정
List<Widget> Problem = [
  ReusableCard(
    problem_num: 1,
  ),
  ReusableCard(
    problem_num: 2,
  ),
  ReusableCard(
    problem_num: 3,
  ),
  ReusableCard(
    problem_num: 4,
  ),
  ReusableCard(
    problem_num: 5,
  ),
  ReusableCard(
    problem_num: 6,
  ),
  ReusableCard(
    problem_num: 7,
  ),
  ReusableCard(
    problem_num: 8,
  ),
  ReusableCard(
    problem_num: 9,
  ),
  ReusableCard(
    problem_num: 10,
  ),
];

//TODO: 문제 리스트 재활용 구현
class ReusableCard extends StatelessWidget {
  ReusableCard(
      {this.problem_num,
      this.correct_ans,
      this.kid_ans,
      this.ox,
      this.problem_sound});

  //문제번호, 정답, 아이의 답, 채점 결과, 문제 음성
  final int problem_num;
  final String correct_ans;
  final Image kid_ans;
  final bool ox;
  final Widget problem_sound; //TODO: 문제 음성 재생을 string으로 선언만 해두었다.

  //아이의 답 이미지 추가
  Widget addKidsAns() {
    return InkWell(
        //TODO: 버튼 이미지 할당
        child: Image.asset('$img_path/.png', width: 300, height: 300),
        onTap: () => problem_sound //TODO: 문제 음성 재생

        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        addKidsAns(), //클릭하면 들을 수 있다.
        kid_ans,
        //ox 여부에 따라 O와 X 아이콘 보여줌
      ]),
    );
  }
}
