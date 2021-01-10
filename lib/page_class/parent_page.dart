import 'package:flutter/material.dart';

class ParentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Learn Korean',
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ReusableCard(
                cardChild: RegistProblem(),
                text: '문제 등록',
                colour: Colors.red[400],
              ),
            ),
            Expanded(
              child: ReusableCard(
                cardChild: RegistProblem(),
                text: '상품 등록',
                colour: Colors.deepOrangeAccent,
              ),
            ),
            Expanded(
              child: ReusableCard(
                  cardChild: RegistProblem(),
                  text: '아이 페이지 전환',
                  colour: Colors.yellow[400]),
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  ReusableCard({this.cardChild, this.text, this.colour});

  final Widget cardChild;
  final String text;
  final colour;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 200.0,
      width: 400.0,
      decoration: BoxDecoration(
        color: colour,
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

class RegistProblem extends StatefulWidget {
  @override
  _RegistProblemState createState() => _RegistProblemState();
}

class _RegistProblemState extends State<RegistProblem> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
