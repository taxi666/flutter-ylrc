import 'package:flutter/material.dart';

class NewRouteGoTest extends StatelessWidget {
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
        title: Text("试卷"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child:Column(
            children: <Widget>[
              
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 24.0),
                child: RichText(
                  
                  text: TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    children: <TextSpan>[
                      TextSpan(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            
                            // fontWeight:'bold',

                          ),
                          text: '剩余时间:'
                        ),
                        
                        TextSpan(
                          style: aboutTextStyle,
                          text: '88',
                        ),
                      
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
