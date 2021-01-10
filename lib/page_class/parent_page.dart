import 'package:flutter/material.dart';
import 'package:learn_korean_for_children/page_class/Explanation.dart';
import 'KidPage.dart';
import 'RegistProblem.dart';

class ParentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            parent_page_card[0],
            parent_page_card[1],
            ConvertToKids(context),
          ],
        ),
      ),
    );
  }
}

List<Widget> parent_page_card = [
  //왼쪽 줄
  Expanded(
    child: Column(
      children: <Widget>[
        //어플설명
        Expanded(
          child: ReusableCard(
            text: "어플 설명",
            cardChild: Explanation(),
          ),
        ),
        //틀린 문제
        Expanded(
          child: ReusableCard(
            text: "틀린 문제",
            cardChild: RegistProblem(),
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
            text: '문제 등록',
            cardChild: RegistProblem(),
          ),
        ),
        //칭찬판
        Expanded(
          child: ReusableCard(
            text: '칭찬판',
            cardChild: Text('칭찬판'),
          ),
        ),
      ],
    ),
  ),
];

Widget ConvertToKids(BuildContext context) {
  return InkWell(
    child: Image.asset('images/KidPage/convert_to_parent.png',
        width: 120, height: 120),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return KidPage();
          },
        ),
      );
    },
  );
}

class ReusableCard extends StatelessWidget {
  ReusableCard({this.cardChild, this.text});

  final Widget cardChild;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: FlatButton(
        onPressed: () {
          print('successfully clicked');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return cardChild;
              },
            ),
          );
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 40.0,
          ),
        ),
      ),
    );
  }
}
