import '../utils/fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'GoTest.dart';

class NewRouteTestCenter extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<NewRouteTestCenter> {
  List subjects = [];
  String title = '';

  @override
  void initState() {
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: getBody(),
      ),
    );
  }

  loadData() async {
    String loadRUL = '/exam/student/paper/list';
    var result =
        await HttpUtils.request(loadRUL, method: HttpUtils.POST, data: {});
    var data = result['data'];
    data.forEach((item) {
      switch (item['examPaperEasy']) {
        case '2':
          item['examPaperEasyText'] = '困难';
          break;
        case '1':
          item['examPaperEasyText'] = '普通';
          break;
        case '0':
          item['examPaperEasyText'] = '简单';
          break;
        default:
          item['examPaperEasyText'] = '简单';
      }
    });
    setState(() {
      subjects = data;
    });
  }

  showNoTest() {
    var row = Container(
      margin: new EdgeInsets.fromLTRB(4, 4, 4, 4),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 16.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                      ),
                      text: '暂无待考信息'),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 16.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      text: '请等待教师分配'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    return row;
  }

  getItem(var subject) {
    var row = Container(
      margin: new EdgeInsets.fromLTRB(4, 4, 4, 4),
      child: Column(
        children: <Widget>[
          new Image.network(
            'https://piao-cdn.o2o.cmbchina.com/images/20180730-193924_750_292_17716ccc56d040ba966cc7281c4baf72.jpg',
          ),
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
                      text: '${subject['examPaperName']}'),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
            alignment: Alignment.centerLeft,
            child: Text('考试科目：${subject['courseName']}',
                textAlign: TextAlign.start),
          ),
          Container(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            alignment: Alignment.centerLeft,
            child: Text('考试时长：${subject['examPaperTime']}分钟',
                textAlign: TextAlign.start),
          ),
          Container(
            padding: const EdgeInsets.only(top: 2.0, bottom: 4.0),
            alignment: Alignment.centerLeft,
            child: Text('题目数量：${subject['subjectNum']}',
                textAlign: TextAlign.start),
          ),
          Container(
            padding: const EdgeInsets.only(top: 2.0, bottom: 4.0),
            alignment: Alignment.centerLeft,
            child: Text('总分：${subject['examPaperScore']}',
                textAlign: TextAlign.start),
          ),
          Container(
            padding: const EdgeInsets.only(top: 2.0, bottom: 4.0),
            alignment: Alignment.centerLeft,
            child: Text('难易程度：${subject['examPaperEasyText']}',
                textAlign: TextAlign.start),
          ),
          Container(
            padding: const EdgeInsets.only(top: 2.0, bottom: 4.0),
            alignment: Alignment.centerLeft,
            child: Text('开始时间：${subject['beginTime']}',
                textAlign: TextAlign.start),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    child: Text("进入考试",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      //在这里不能通过此方式获取FormState，context不对
                      //print(Form.of(context));
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (context) {
                        return new NewRouteGoTest(
                            planId: subject['examPlanId'],
                            paperId: subject['examPaperId']
                          );
                      }));
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
    return Card(
      margin: new EdgeInsets.fromLTRB(4, 4, 4, 20),
      child: row,
    );
  }

  getBody() {
    if (subjects.length != 0) {
      return ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (BuildContext context, int position) {
            return getItem(subjects[position]);
          });
    } else {
      return showNoTest();
      // 加载菊花
      // return CupertinoActivityIndicator();
    }
  }
}
