import 'package:flutter/material.dart';

class ParentPraise extends StatefulWidget {
  @override
  _ParentPraiseState createState() => _ParentPraiseState();
}

class _ParentPraiseState extends State<ParentPraise> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    '상품 추가',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ReusableProduct(text: '1단계'),
                ReusableProduct(text: '2단계'),
                ReusableProduct(text: '3단계'),
                ReusableProduct(text: '4단계'),
                ReusableProduct(text: '5단계'),
                ReusableProduct(text: '6단계'),
                ReusableProduct(text: '7단계'),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

class ReusableProduct extends StatelessWidget {
  ReusableProduct({this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 20,
        ),
        Container(
          color: Colors.red[200],
          child: Text(
            '$text',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          height: 30,
          width: 400,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'input',
            ),
          ),
        ),
        FlatButton(
          onPressed: () {},
          color: Colors.blue[100],
          child: Text('상품 관리'),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
