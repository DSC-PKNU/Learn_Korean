import 'package:flutter/material.dart';
import 'package:learn_korean_for_children/page_class/Explanation.dart';
import 'package:learn_korean_for_children/page_class/IncorrectProblem.dart';
import 'KidPage.dart';
import 'RegistProblem.dart';
import 'PrarentPraise.dart';

String imgPath = 'images/ParentPage';

class ParentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            parentPageCard[0],
            parentPageCard[1],

            convertToKids(context),
          ],
        ),
      ),
    );
  }
}

List<Widget> parentPageCard = [
  //왼쪽 줄
  Expanded(
    child: Column(
      children: <Widget>[
        //어플설명
        Expanded(
          child: ReusableCard(
            text: "wrong_problem",
            cardChild: IncorrectProblem(),
          ),
        ),
        //틀린 문제
        Expanded(
          child: ReusableCard(
            text: "praise",
            cardChild: ParentPraise(),
          ),
        ),
      ],
    ),
  ),

  //두번째 줄
  Expanded(
    child: Column(
      children: <Widget>[
        //문제 등록
        Expanded(
          child: ReusableCard(
            text: 'regist_problem',
            cardChild: RegistProblem(),
          ),
        ),
        //칭찬판
        Expanded(
          child: ReusableCard(
            text: 'howtouse',
            cardChild: Explanation(),
          ),
        ),
      ],
    ),
  ),
];

Widget convertToKids(BuildContext context) {
  return InkWell(
    child: Image.asset('$imgPath/convert_to_kid.png',
        width: 120, height: 120),
    onTap: () {
      Navigator.pop(context);
    },
  );
}

class ReusableCard extends StatelessWidget {
  ReusableCard({this.cardChild, this.text});

  final Widget cardChild;
  final String text;

  Widget addButton(BuildContext context) {
    return InkWell(
        child: Image.asset('$imgPath/$text.png', width: 300, height: 300),
        onTap: () => Navigator.push(context,
                MaterialPageRoute<void>(builder: (BuildContext context) {
              return cardChild;
            })));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(10.0),
      // ),
      // child: FlatButton(
      //   onPressed: () {
      //     print('successfully clicked');
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (BuildContext context) {
      //           return cardChild;
      //         },
      //       ),
      //     );
      //   },
      //   child: Text(
      //     text,
      //     style: TextStyle(
      //       fontSize: 40.0,
      //     ),
      //   ),
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [addButton(context)],
      ),
    );
  }
}
