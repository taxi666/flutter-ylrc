import '../utils/fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

class NewRouteGoTest extends StatefulWidget {
  var planId;
  var paperId;
  NewRouteGoTest({this.planId, this.paperId});
  @override
  GoTestViewState createState() => GoTestViewState(planId, paperId);
}

class GoTestViewState extends State<NewRouteGoTest> {
  List subjects = [];
  List results = [];
  int nowIndex = 0;

  ///更新group的值,Radio的value==groupValue时候,则按钮选中
  void updateGroupValue(String e, var index) {
    setState(() {
      results[index]['result'] = e;
    });
  }

  void updateCheckboxStatus(bool e, var index, var index0) {
    setState(() {
      results[index]['checkedList'][index0] = e;
    });
  }

  void updateTextValue(String e, var index) {
    setState(() {
      results[index]['result'] = e;
    });
  }

  ///上一题
  void goPrev() {
    setState(() {
      nowIndex = nowIndex > 0 ? --nowIndex : 0;
      ansNum = computeNum();
    });
  }

  ///下一题
  void goNext() {
    setState(() {
      nowIndex =
          nowIndex < results.length - 1 ? ++nowIndex : results.length - 1;
      ansNum = computeNum();
    });
  }

  String title = '';
  int valTime = 0;
  int allNum = 0;
  int ansNum = 0;
  String valTimeTxt = '';
  var planId;
  var paperId;
  var loaded = false;
  Timer _countdownTimer;
  GoTestViewState(this.planId, this.paperId);

  //计算剩余时间
  String resultFormat(result) {
    var m = (result / 60).toInt();
    var s = result % 60;
    String r = '';
    r = m.toString() + '"' + s.toString() + '\'';
    return r;
  }

  void computTime() {
    _countdownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {
        if (valTime > 1)
          valTime = valTime - 1;
        else {
          valTime = 0;
        }
        valTimeTxt = resultFormat(valTime);
      });
    });
  }

  //计算已答题个数
  int computeNum() {
    int r = 0;
    results.asMap().forEach((index, item) {
      if (subjects[index]['subjectType'] == '0' ||
          subjects[index]['subjectType'] == '2') {
        if (item['result'] != '') {
          r++;
          return;
        }
      } else if (subjects[index]['subjectType'] == '1') {
        if (item['checkedList'][0]) {
          print(item['checkedList'][0]);
          r++;
          return;
        }
        if (item['checkedList'][1]) {
          r++;
          return;
        }
        if (item['checkedList'][2]) {
          r++;
          return;
        }
        if (item['checkedList'][3]) {
          r++;
          return;
        }
        if (item['checkedList'][4]) {
          r++;
          return;
        }
        if (item['checkedList'][5]) {
          r++;
          return;
        }
        if (item['checkedList'][6]) {
          r++;
          return;
        }
        if (item['checkedList'][7]) {
          r++;
          return;
        }
      }
    });

    return r > allNum ? allNum : r;
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // 不要忘记在这里释放掉Timer
  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('剩余时间：' + valTimeTxt),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.topLeft, //指定未定位或部分定位widget的对齐方式
          fit: StackFit.expand, //未定位widget占满Stack整个空间
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 40.0, bottom: 4.0),
              child: getBody(),
              // style: TextStyle(color: Colors.black)),
              // color: Colors.red,
            ),
            Positioned(
              left: 0.0,
              top: 0,
              child: Container(
                  width: screenWidth,
                  color: Colors.black12,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                      top: 6.0, left: 12.0, right: 6.0, bottom: 6.0),
                  child: new Row(
                      //行控件
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, //对齐方式：平均间隔
                      children: [
                        GestureDetector(
                          onTap: submitExam,
                          child: Container(
                              child: Row(children: [
                            Icon(Icons.check, color: Colors.redAccent),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                    text: '点击交卷',
                                  ),
                                ],
                              ),
                            ),
                          ])),
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                style: TextStyle(
                                  color: Colors.black38,
                                ),
                                text: '已答：',
                              ),
                              TextSpan(
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                                text: ansNum.toString(),
                              ),
                              TextSpan(
                                style: TextStyle(
                                  color: Colors.black38,
                                ),
                                text: '/' + allNum.toString(),
                              ),
                            ],
                          ),
                        ),
                      ])),
            ),

            // Positioned(
            //     bottom: 50.0,
            //     child: Container(
            //       width: screenWidth,
            //       alignment: Alignment.center,
            //       child: RaisedButton(
            //         padding: const EdgeInsets.only(
            //             top: 8.0, bottom: 8.0, left: 30, right: 30),
            //         child: Text(
            //           '交卷',
            //           textAlign: TextAlign.start,
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 28,
            //           ),
            //         ),
            //         color: Colors.cyan[600],
            //         textColor: Colors.white,
            //         onPressed: submitExam,
            //       ),
            //     ))
          ],
        ),
      ),
    );
  }

  loadData() async {
    String loadRUL = '/exam/student/paper/getSubject';
    var param = {"examPlanId": planId};
    var result =
        await HttpUtils.request(loadRUL, method: HttpUtils.POST, data: param);
    print('result');
    print(result);

    if (result == null) {
      Navigator.pop(context);
      return;
    }
    var data = result['data'];

    loaded = true;
    data["subjectList"].forEach((item) {
      Map<String, Object> map = new Map<String, Object>();
      map["subjectId"] = item["subjectId"];
      map["result"] = '';
      map["checkedList"] = [
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false
      ];
      map["show"] = false;
      results.add(map);
    });
    results[0]["show"] = true;
    setState(() {
      subjects = data["subjectList"];
      allNum = subjects.length;
      valTime = int.parse(data["expTime"]);
      computTime();
    });
  }

  submitExam() async {
    //交卷
    String loadRUL = '/exam/student/paper/submit';
    results.asMap().forEach((index, item) {
      if (subjects[index]['subjectType'] == '1') {
        String r = '';
        if (item['checkedList'][0]) r = 'A,';
        if (item['checkedList'][1]) r = '${r}B,';
        if (item['checkedList'][2]) r = '${r}C,';
        if (item['checkedList'][3]) r = '${r}D,';
        if (item['checkedList'][4]) r = '${r}E,';
        if (item['checkedList'][5]) r = '${r}F,';
        if (item['checkedList'][6]) r = '${r}G,';
        if (item['checkedList'][7]) r = '${r}H,';
        if (r.length > 0) item['result'] = r.substring(0, r.length - 1);
      }
    });
    var param = {"examPaperId": this.paperId, "answerList": results};
    var result =
        await HttpUtils.request(loadRUL, method: HttpUtils.POST, data: param);
    print('result');
    print(result);
    if (result != null && result['code'] == 'S0000000') {
      Navigator.pop(context);
    }

    // setState(() {

    // });
  }

  getDanxuanOption(subject, option, index) {
    var t = 'option' + option;
    if (subject[t] != null && subject[t] != '') {
      return Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: Column(
            children: <Widget>[
              new RadioListTile<String>(
                title: Text(
                  '${subject[t]}',
                  style: TextStyle(fontSize: 20),
                ),
                value: option,
                groupValue: results[index]['result'],
                onChanged: (String e) => updateGroupValue(e, index),
              )
            ],
          ));
    } else {
      return Container();
    }
  }

  getDuoxuanOption(subject, option, index, oIndex) {
    var t = 'option' + option;
    if (subject[t] != null && subject[t] != '') {
      return Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: Column(
            children: <Widget>[
              new CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('${subject[t]}', style: TextStyle(fontSize: 20)),
                  value: results[index]['checkedList'][oIndex],
                  onChanged: (bool) =>
                      updateCheckboxStatus(bool, index, oIndex)),
            ],
          ));
    } else {
      return Container();
    }
  }

  getDanxuan(var subject, var index) {
    var row = Container(
        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
        width: index == nowIndex ? MediaQuery.of(context).size.width : 0.0,
        height: index == nowIndex ? MediaQuery.of(context).size.height : 0.0,
        alignment: Alignment.centerLeft,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  '${index + 1}.${subject['subjectName']}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    getDanxuanOption(subject, 'A', index),
                    getDanxuanOption(subject, 'B', index),
                    getDanxuanOption(subject, 'C', index),
                    getDanxuanOption(subject, 'D', index),
                    getDanxuanOption(subject, 'E', index),
                    getDanxuanOption(subject, 'F', index),
                    getDanxuanOption(subject, 'G', index),
                    getDanxuanOption(subject, 'H', index),
                    Container(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "上一题",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onPressed: goPrev,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: RaisedButton(
                              padding: EdgeInsets.all(12.0),
                              child: Text("下一题",
                                  style: TextStyle(
                                    fontSize: 18,
                                  )),
                              color: Theme.of(context).primaryColorDark,
                              textColor: Colors.white,
                              onPressed: () {
                                goNext();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]));
    return row;
  }

  getDuoxuan(var subject, var index) {
    var row = Container(
        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
        width: index == nowIndex ? MediaQuery.of(context).size.width : 0.0,
        height: index == nowIndex ? MediaQuery.of(context).size.height : 0.0,
        alignment: Alignment.centerLeft,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  '${index + 1}.${subject['subjectName']}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    getDuoxuanOption(subject, 'A', index, 0),
                    getDuoxuanOption(subject, 'B', index, 1),
                    getDuoxuanOption(subject, 'C', index, 2),
                    getDuoxuanOption(subject, 'D', index, 3),
                    getDuoxuanOption(subject, 'E', index, 4),
                    getDuoxuanOption(subject, 'F', index, 5),
                    getDuoxuanOption(subject, 'G', index, 6),
                    getDuoxuanOption(subject, 'H', index, 7),
                    Container(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            padding: EdgeInsets.all(12.0),
                            child: Text("上一题",
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onPressed: goPrev,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: RaisedButton(
                              padding: EdgeInsets.all(12.0),
                              child: Text("下一题",
                                  style: TextStyle(
                                    fontSize: 18,
                                  )),
                              color: Theme.of(context).primaryColorDark,
                              textColor: Colors.white,
                              onPressed: () {
                                goNext();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]));
    return row;
  }

  getJianda(var subject, var index) {
    var row = Container(
        padding:
            const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20, right: 20),
        width: index == nowIndex ? MediaQuery.of(context).size.width : 0.0,
        height: index == nowIndex ? MediaQuery.of(context).size.height : 0.0,
        alignment: Alignment.centerLeft,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  '${index + 1}.${subject['subjectName']}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                // width:MediaQuery.of(context).size.width-50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        child: Column(
                      children: <Widget>[
                        new TextField(
                          autofocus: true,
                          onChanged: (String e) => updateTextValue(e, index),
                          maxLines: 5, //最大行数
                          // decoration: new InputDecoration(
                          //   hintText: 'Type something',
                          // ),
                        ),
                      ],
                    )),
                    Container(
                      padding: const EdgeInsets.only(top: 28.0, bottom: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            padding: EdgeInsets.all(12.0),
                            child: Text("上一题",
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onPressed: goPrev,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: RaisedButton(
                              padding: EdgeInsets.all(12.0),
                              child: Text("下一题",
                                  style: TextStyle(
                                    fontSize: 18,
                                  )),
                              color: Theme.of(context).primaryColorDark,
                              textColor: Colors.white,
                              onPressed: () {
                                goNext();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]));
    return row;
  }

  showNoTest() {
    var row = Container(
      margin: new EdgeInsets.fromLTRB(4, 4, 4, 4),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 16.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                      ),
                      text: '暂无试题'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    return row;
  }

  getBody() {
    if (subjects.length != 0) {
      return ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (BuildContext context, int position) {
            if (subjects[position]['subjectType'] == '0')
              return getDanxuan(subjects[position], position);
            else if (subjects[position]['subjectType'] == '1') {
              // print(subjects[position]);
              return getDuoxuan(subjects[position], position);
            } else if (subjects[position]['subjectType'] == '2')
              return getJianda(subjects[position], position);
          });
    } else {
      // return showNoTest();
      // 加载菊花
      return CupertinoActivityIndicator();
    }
  }
}
