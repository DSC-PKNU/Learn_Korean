import 'package:flutter/material.dart';

class RegistProblem extends StatefulWidget {
  @override
  _RegistProblemState createState() => _RegistProblemState();
}

class _RegistProblemState extends State<RegistProblem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            '문제 등록',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(),
          ),
          Row(
            children: [
              Expanded(
                child: FlatButton(
                  color: Colors.blue[200],
                  onPressed: () {
                    //문제 등록하는 함수
                  },
                  child: Text(
                    '등록',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(
                  color: Colors.red[300],
                  onPressed: () {
                    //문제 삭제하는 함수
                  },
                  child: Text(
                    '삭제',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
