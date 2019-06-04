import 'package:flutter/material.dart';
// import 'register.dart';
import 'package:dio/dio.dart';

class FormTestRoute extends StatefulWidget {
  @override
  _FormTestRouteState createState() => new _FormTestRouteState();
}

class _FormTestRouteState extends State<FormTestRoute> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey= new GlobalKey<FormState>();
  void getHttp() async {
    try {
      Response response = await Dio().get("http://www.google.com");
      print(response);
    } catch (e) {
      print(e);
    }
  }
  _airDress(){
    Navigator.push( context,
    new MaterialPageRoute(builder: (context) {
          return new FormTestRoute();
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('登录'),
        actions: <Widget>[
          // Container(
          // margin: const EdgeInsets.all(10.0),
          // // color: const Color(0xFF00FF00),
          // width: 48.0,
          // height: 48.0,
          // alignment:Alignment(0, 0),
          // onPressed: _airDress,
          // child: Text(
          //   '注册',
          //   // textAlign:TextAlign.center,
          //   style: TextStyle(fontWeight: FontWeight.bold),
            
          // ),
          
        // ),
        // FlatButton(
        //   child: Text("注册"),
        //   textColor: Colors.white,
        //   onPressed: () {
        //     //导航到新路由   
        //       Navigator.push( context,
        //       new MaterialPageRoute(builder: (context) {
        //             return new FormRegister();
        //       }));
        //     },
        //   ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidate: false, //开启自动校验
          child: Column(
            children: <Widget>[
              TextFormField(
                  autofocus: true,
                  controller: _unameController,
                  decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "用户名或邮箱",
                      icon: Icon(Icons.person)
                  ),
                  // 校验用户名
                  validator: (v) {
                    return v
                        .trim()
                        .length > 0 ? null : "用户名不能为空";
                  }

              ),
              TextFormField(
                  controller: _pwdController,
                  decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "您的登录密码",
                      icon: Icon(Icons.lock)
                  ),
                  obscureText: true,
                  //校验密码
                  validator: (v) {
                    return v
                        .trim()
                        .length > 5 ? null : "密码不能少于6位";
                  }
              ),
              // 登录按钮
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("登录"),
                        color: Theme
                            .of(context)
                            .primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          //在这里不能通过此方式获取FormState，context不对
                          //print(Form.of(context));

                          // 通过_formKey.currentState 获取FormState后，
                          // 调用validate()方法校验用户名密码是否合法，校验
                          // 通过后再提交数据。 

                          if((_formKey.currentState as FormState).validate()){
                            // getHttp();
                            //验证通过提交数据
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}