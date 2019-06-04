import 'package:flutter/material.dart';

class NewRoute extends StatelessWidget {
  final TextStyle aboutTextStyle = TextStyle(
          color: Colors.black,
          decoration: TextDecoration.underline,
          decorationColor: Colors.red,
          decorationStyle: TextDecorationStyle.wavy,
        );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("考试中心"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child:Column(
            children: <Widget>[
              new Image.network(
                'https://piao-cdn.o2o.cmbchina.com/images/20180730-193924_750_292_17716ccc56d040ba966cc7281c4baf72.jpg',
              ),
              Container(
                alignment: Alignment.centerLeft,
                
                padding: const EdgeInsets.only(top: 24.0),
                child: RichText(
                  
                  text: TextSpan(
                    
                    children: <TextSpan>[
                      TextSpan(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            
                            // fontWeight:'bold',

                          ),
                          text: '语文三单元测试 '
                        ),
                        
                      //   TextSpan(
                      //     style: aboutTextStyle,
                      //     text: '考试科目：网络安全    ',
                      // ),
                      
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                alignment: Alignment.centerLeft,
                child: Text('考试科目：安徽', textAlign: TextAlign.start),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                alignment: Alignment.centerLeft,
                child: Text('考试科目：安徽', textAlign: TextAlign.start),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                alignment: Alignment.centerLeft,
                child: Text('考试科目：安徽', textAlign: TextAlign.start),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                alignment: Alignment.centerLeft,
                child: Text('考试科目：安徽', textAlign: TextAlign.start),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                alignment: Alignment.centerLeft,
                child: Text('考试科目：安徽', textAlign: TextAlign.start),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                alignment: Alignment.centerLeft,
                child: Text('考试科目：安徽', textAlign: TextAlign.start),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("进入考试",style: TextStyle(
                            fontSize:18,
                          )),
                        color: Theme
                            .of(context)
                            .primaryColor,
                        textColor: Colors.white,
                        
                        onPressed: () {
                          //在这里不能通过此方式获取FormState，context不对
                          //print(Form.of(context));

                        },
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
}
