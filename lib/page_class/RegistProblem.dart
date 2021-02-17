import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_korean_for_children/controllor/problem_regist_controllor.dart';
import 'package:learn_korean_for_children/model/ProblemModel.dart';

class RegistProblem extends StatefulWidget {
  @override
  _RegistProblemState createState() => _RegistProblemState();
}

class _RegistProblemState extends State<RegistProblem> {
  TextEditingController _problemTextFieldControllor = TextEditingController();
  ProblemRegistControllor problemRegistControllor = ProblemRegistControllor();
  @override
  void initState() {
    create();
    super.initState();
  }

  List<ProblemModel> problems = [];

  create() {
    problemRegistControllor.loadSqlite().then((value) {
      setState(() {
        problems = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height - 69,
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    thickness: 3,
                  ),
                  itemCount: problems.length,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Row(
                      children: [
                        Text(problems[index].problem),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.border_color),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  _dialog(true, modifyModel: problems[index]),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            problemRegistControllor
                                .deleteSqlite(problems[index]);
                            create();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: FlatButton(
                      color: Colors.blue[200],
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => _dialog(false),
                        );
                      },
                      child: Text(
                        '등록',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Dialog _dialog(bool mode, {ProblemModel modifyModel}) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    if (modifyModel != null)
      _problemTextFieldControllor.text = modifyModel.problem;
    return Dialog(
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              mode == false ? '문제 등록' : '문제 수정',
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
                controller: _problemTextFieldControllor,
                expands: false,
                decoration: InputDecoration(border: OutlineInputBorder()),
              )),
          Row(
            children: [
              Expanded(
                child: FlatButton(
                  color: Colors.blue[200],
                  onPressed: () {
                    if (_problemTextFieldControllor.text != null &&
                        _problemTextFieldControllor.text != "") {
                      if (mode == false) {
                        problemRegistControllor
                            .saveSqlite(ProblemModel(
                                problem: _problemTextFieldControllor.text))
                            .then((value) {
                          if (value) {
                            create();
                            Navigator.pop(context);
                          } else {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("중복된 문제가 있습니다.")));
                          }
                        });
                      } else {
                        problemRegistControllor
                            .modifySqlite(
                                modifyModel, _problemTextFieldControllor.text)
                            .then((value) {
                          if (value) {
                            create();
                            Navigator.pop(context);
                          } else {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("중복된 문제가 있습니다.")));
                          }
                        });
                      }
                    } else {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text("문제를 입력하세요.")));
                    }
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
