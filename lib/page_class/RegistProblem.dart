import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegistProblem extends StatefulWidget {
  @override
  _RegistProblemState createState() => _RegistProblemState();
}

class _RegistProblemState extends State<RegistProblem> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      showDialog(
                        context: context,
                        builder: (context) => _dialog(),
                      );
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
      ),
    );
  }

  Dialog _dialog() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Dialog(
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '문제 등록',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.02, bottom: 10),
            child: Text('문제를 입력하세요'),
          ),
          Container(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02,
                  bottom: 20),
              child: TextFormField(
                expands: false,
                decoration: InputDecoration(border: OutlineInputBorder()),
              )),
              
          Row(
            children: [
              Expanded(
                child: FlatButton(
                  color: Colors.blue[200],
                  onPressed: () {
                    //문제 등록하는 함수
                  },
                  child: Text(
                    '확인',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(
                  color: Colors.red[300],
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '취소',
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
