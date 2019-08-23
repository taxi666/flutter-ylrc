import 'package:flutter/material.dart';
import 'home_page.dart';
import './pages/TestCenter.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './globals.dart' as globals;
Dio dio = new Dio();
class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey _formKey= new GlobalKey<FormState>();
  void getHttp(uname,password) async {
    try {
      Response response = await dio.post("http://39.108.177.24:11401/gateway/main/restapi/exam/student/sign/login", 
      data: {"account":uname,"password":password });
      var data=response.data;
      print(data);
      if(data['code']=='S0000000'){
        globals.isLoggedIn = true;
        globals.token = data['data']['token'];
        // Fluttertoast.showToast(
        //   msg: "登录成功",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.CENTER,
        //   timeInSecForIos: 1,
        //   backgroundColor: Colors.black,
        //   textColor: Colors.white,
        //   fontSize: 16.0
        // );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => NewRouteTestCenter()),
                (route) => route==null
        );
      }
      else {
        Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
        );
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: '后台服务异常',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
        );
    }
  }
  var _photoController = TextEditingController();
  var _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset('images/logo.jpg'),
            ),
            Form(
              key: _formKey, //设置globalKey，用于后面获取FormState
              autovalidate: false, //开启自动校验
              child: Column(
                 children: <Widget>[
                    AccountTextField(),
                    PasswordTextField(),
                    LoginButton()
                 ]
              )
            )
            
          ],
        ),
      ),
    );
  }

  // 账号TextField
  Widget AccountTextField() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
        child: TextFormField(
          autofocus: true,
          controller: _photoController,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone_iphone),
              fillColor: Colors.white70,
              filled: true,
              labelText: '请输入登录账号'
          ),
          // 校验用户名
          validator: (v) {
            return v
                .trim()
                .length > 0 ? null : "用户名不能为空";
          }
        )
    );
  }

  // 密码TextField
  Widget PasswordTextField() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
        child: TextFormField(
          controller: _passController,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              fillColor: Colors.white70,
              filled: true,
              labelText: '请输入密码'
          ),
          //校验密码
          validator: (v) {
            return v
                .trim()
                .length > 0 ? null : "密码不能为空";
          },
          obscureText: true,
        )
    );
  }

  // 登录按钮
  Widget LoginButton() {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
        width: MediaQuery.of(context).size.width - 30.0,
        height: 50.0,
        child: Card(
          color: Colors.lightBlue,
          elevation: 6.0,
          child: Center(
            child: Text('登录', style: TextStyle(fontSize: 18.0, color: Colors.white)),
          )
        )
      ),
      onTap: (){

        if((_formKey.currentState as FormState).validate()){
          String uname=_photoController.text;
          String password=_passController.text;
          getHttp(uname,password);
        }
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => HomePage()),
        //         (route) => route==null
        // );
      },
    );
  }

}




