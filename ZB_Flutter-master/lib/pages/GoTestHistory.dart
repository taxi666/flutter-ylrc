import '../utils/fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';


class NewRouteGoHistoryTest extends StatefulWidget {
  var planId;
  var paperId;
  NewRouteGoHistoryTest({this.planId, this.paperId});
  @override
  GoTestViewState createState() => GoTestViewState(planId, paperId);
}

class GoTestViewState extends State<NewRouteGoHistoryTest> {
  List subjects = [];
  List results = [];
  int nowIndex = 0;

  ///上一题
  void goPrev() {
    setState(() {
      nowIndex = nowIndex > 0 ? --nowIndex : 0;
    });
  }

  ///下一题
  void goNext() {
    setState(() {
      nowIndex =nowIndex < subjects.length - 1 ? ++nowIndex : subjects.length - 1;
    });
  }

  String title = '';
  int allNum=0;
  int ansNum=0;
  String valTimeTxt='';
  var planId;
  var paperId;
  var loaded = false;
  Timer _countdownTimer;
  GoTestViewState(this.planId, this.paperId);

  
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
        title: Text('考试历史'),
        backgroundColor: Color.fromRGBO(108, 121, 219, 1.0), //导航栏和状态栏的的颜色

      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.topLeft, //指定未定位或部分定位widget的对齐方式
          fit: StackFit.expand, //未定位widget占满Stack整个空间
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 40.0, bottom: 4.0),
              child: getBody()
            ),
          ],
        ),
      ),
    );
  }

  loadData() async {
    String loadRUL = '/exam/student/paper/review';
    var param = {"examPaperId": paperId};
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
    data.forEach((item) {
      Map<String, Object> map = new Map<String, Object>();
      map["easy"] = item['subjectEasy']=='0'?'简单':item['subjectEasy']=='1'?'普通':'困难';
      // map["checkedList"]=[false,false,false,false,false,false,false,false];
      // map["show"] = false;
      results.add(map);
    });
    print(data);
    print('data');
    setState(() {
      subjects = data;
      // allNum=subjects.length;
    });
  }



  getDanxuanOption(subject,option,index) {
    var t='option'+option;
    var s='score'+option;
    if(subject[t] != null && subject[t]!=''){
      // return Container(
      // width:  MediaQuery.of(context).size.width,
      // height: 60,
      // child: Column(
      //   children: <Widget>[
      //     new RadioListTile<String>(
      //       title: Text(option+'${subject[t]}'),
      //       value: option,
      //       groupValue: results[index]['result'],
      //       onChanged: (String e) => updateGroupValue(e, index),
      //     )
      //   ],
      // ));
      return Container(
          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0,left:28),
          alignment: Alignment.centerLeft,
          child:
            RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18
                          ),
                          text: option+'. '+'${subject[t]} ',
                        ),
                        TextSpan(
                          style: TextStyle(
                            color: subject[s]==0?Colors.white:Colors.black87,
                            fontSize: 18
                          ),
                          text: ' 分值:',
                        ),
                        TextSpan(
                          style: TextStyle(
                            color: subject[s]==0?Colors.white:Colors.black87,
                            fontSize: 18
                          ),
                          text: '${subject[s]}',
                        ),
                      ],
                    ),
                  )
           
        );
    } 
    else {
      return Container();
    }
  }
  getDuoxuanOption(subject,option,index,oIndex) {
    var t='option'+option;
    if(subject[t] != null && subject[t]!=''){
      // return Container(
      //   width:MediaQuery.of(context).size.width,
      //   height: 60,
      //   child: Column(
      //     children: <Widget>[
      //       new CheckboxListTile(
      //   controlAffinity: ListTileControlAffinity.leading,
      //   title:Text('${subject[t]}'),
      //   value: results[index]['checkedList'][oIndex],
      //   onChanged: (bool) => updateCheckboxStatus(bool,index,oIndex)),
      //     ],
      //   ));
      return Container(
          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
          alignment: Alignment.centerLeft,
          child: Text(option+'${subject[t]}',  
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 18,
                )
              ),
        );
    } 
    else {

      return Container();
    }
  }

  getDanxuan(var subject, var index) {
    var row = Container(
        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
        width: index == nowIndex ? MediaQuery.of(context).size.width : 0.0,
        height: index == nowIndex ? MediaQuery.of(context).size.height : 0.0,
        alignment: Alignment.centerLeft,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
          Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              '${index + 1}.${subject['subjectName']}',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize:22,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //我用IOS模拟器测试的时候,不设置亲和力,默认值是platform，按钮展示在文字后面,很丑啊
                
                getDanxuanOption(subject,'A',index),
                getDanxuanOption(subject,'B',index),                
                getDanxuanOption(subject,'C',index),
                getDanxuanOption(subject,'D',index),
                getDanxuanOption(subject,'E',index),
                getDanxuanOption(subject,'F',index),
                getDanxuanOption(subject,'G',index),
                getDanxuanOption(subject,'H',index),
                Container(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
                  alignment: Alignment.centerLeft,
                  child:
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18
                          ),
                          text: '选择答案：',
                        ),
                        TextSpan(
                          style: TextStyle(
                            color: subject['answer']==subject['rightResult']?Colors.green:Colors.red,
                            fontSize: 18
                          ),
                          text: '${subject['answer']}',
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: subject['rightResult']==null?0:MediaQuery.of(context).size.width,
                  height: subject['rightResult']==null?0:40,
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
                  alignment: Alignment.centerLeft,
                  child:
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18
                          ),
                          text: '正确答案：',
                        ),
                        TextSpan(
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18
                          ),
                          text: '${subject['rightResult']}',
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
                  alignment: Alignment.centerLeft,
                  child:
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18
                          ),
                          text: '分值：',
                        ),
                        TextSpan(
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18
                          ),
                          text: '${subject['subjectScore']}',
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
                  alignment: Alignment.centerLeft,
                  child:
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18
                          ),
                          text: '难易程度：',
                        ),
                        TextSpan(
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18
                          ),
                          text: '${results[index]['easy']}',
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        padding: EdgeInsets.all(12.0),
                        child: Text("上一题",
                          style: TextStyle(
                                fontSize:18,
                              )
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
                              fontSize:18,
                            )
                          ),
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
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
          Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              '${index + 1}.${subject['subjectName']}',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                getDuoxuanOption(subject,'A',index,2),
                getDuoxuanOption(subject,'B',index,2),
                getDuoxuanOption(subject,'C',index,2),
                getDuoxuanOption(subject,'D',index,3),
                getDuoxuanOption(subject,'E',index,4),
                getDuoxuanOption(subject,'F',index,5),
                getDuoxuanOption(subject,'G',index,6),
                getDuoxuanOption(subject,'H',index,7),
                Container(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        padding: EdgeInsets.all(12.0),
                        child: Text("上一题"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: goPrev,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: RaisedButton(
                          padding: EdgeInsets.all(12.0),
                          child: Text("下一题"),
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
        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20,right:20),
        width: index == nowIndex ? MediaQuery.of(context).size.width : 0.0,
        height: index == nowIndex ? MediaQuery.of(context).size.height : 0.0,
        alignment: Alignment.centerLeft,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
          Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
            alignment: Alignment.centerLeft,
            child: Text(
              '${index + 1}.${subject['subjectName']}',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 8.0, bottom:4.0),
            // width:MediaQuery.of(context).size.width-50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                
                
                Container(
                  padding: const EdgeInsets.only(top: 28.0, bottom: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        padding: EdgeInsets.all(12.0),
                        child: Text("上一题"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: goPrev,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: RaisedButton(
                          padding: EdgeInsets.all(12.0),
                          child: Text("下一题"),
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
             return getDanxuan(subjects[position], position);
            // if (subjects[position]['subjectType'] == '0')
            //   return getDanxuan(subjects[position], position);
            // else if (subjects[position]['subjectType'] == '1'){
            //   // print(subjects[position]);
            //   return getDuoxuan(subjects[position], position);
            // }
            // else if (subjects[position]['subjectType'] == '2')
            //   return getJianda(subjects[position], position);
          }
        );
    } else {
      // return showNoTest();
      // 加载菊花
      return CupertinoActivityIndicator();
    }
  }
}
