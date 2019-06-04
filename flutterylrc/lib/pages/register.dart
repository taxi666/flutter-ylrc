import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'dart:convert';
  const PickerData = '''
[
    {
        "a": [
            {
                "a1": [
                    1,
                    2,
                    3,
                    4
                ]
            },
            {
                "a2": [
                    5,
                    6,
                    7,
                    8
                ]
            },
            {
                "a3": [
                    9,
                    10,
                    11,
                    12
                ]
            }
        ]
    },
    {
        "b": [
            {
                "b1": [
                    11,
                    22,
                    33,
                    44
                ]
            },
            {
                "b2": [
                    55,
                    66,
                    77,
                    88
                ]
            },
            {
                "b3": [
                    99,
                    1010,
                    1111,
                    1212
                ]
            }
        ]
    },
    {
        "c": [
            {
                "c1": [
                    "a",
                    "b",
                    "c"
                ]
            },
            {
                "c2": [
                    "aa",
                    "bb",
                    "cc"
                ]
            },
            {
                "c3": [
                    "aaa",
                    "bbb",
                    "ccc"
                ]
            }
        ]
    }
]''';
Map classMap = { '1': '高一1班',
                  '2': '高一2班',
                  '3': '高一3班' };
class FormRegister extends StatefulWidget {
  @override
  _FormRegisterState createState() => new _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  TextEditingController _rnameController = new TextEditingController();
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey= new GlobalKey<FormState>();
  String dropdownValue='One';

  _airDress(){
    Navigator.push( context,
    new MaterialPageRoute(builder: (context) {
          return new FormRegister();
    }));
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('注册')
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
                  controller: _rnameController,
                  decoration: InputDecoration(
                      labelText: "真实姓名",
                      hintText: "真实姓名",
                      icon: Icon(Icons.person)
                  ),
                  // 校验真实姓名
                  validator: (v) {
                    return v
                        .trim()
                        .length > 0 ? null : "姓名不能为空";
                  }

              ),
              TextFormField(
                  autofocus: true,
                  controller: _unameController,
                  decoration: InputDecoration(
                      labelText: "登录账号",
                      hintText: "考试登录账号",
                      icon: Icon(Icons.person)
                  ),
                  validator: (v) {
                    return v
                        .trim()
                        .length > 0 ? null : "登录账号不能为空";
                  }

              ),

              TextFormField(
                  controller: _pwdController,
                  decoration: InputDecoration(
                      labelText: "登录密码",
                      hintText: "考试登录密码",
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
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: DropdownButton<String>(
                    value: dropdownValue,
                    // style: new StrutStyle(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    
                    items: <String>['One', 'Two', 'Free', 'Four']
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text('高一一班'),
                        );
                      })
                      .toList(),
                  ),
                    ),
                  ],
                ),
              ),
              
              // Padding(
              //   padding: const EdgeInsets.only(top: 28.0),
              //   child: Row(
              //     children: <Widget>[
              //       Expanded(
              //         child: RaisedButton(
              //           child: Text('选择班级'),
              //           onPressed: () {
              //             showPickerDialog(context);
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              
              // 登录按钮
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("注册"),
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
  showPicker(BuildContext context) {
    Picker picker = Picker(
      adapter: PickerDataAdapter<String>(pickerdata: JsonDecoder().convert(PickerData)),
      changeToFirst: true,
      textAlign: TextAlign.left,
      textStyle: const TextStyle(color: Colors.blue),
      columnPadding: const EdgeInsets.all(8.0),
      onConfirm: (Picker picker, List value) {
        print(value.toString());
        print(picker.getSelectedValues());
      }
    );
    picker.show(_scaffoldKey.currentState);
  }
}
showPickerDialog(BuildContext context) {
    Picker(
        adapter: PickerDataAdapter<String>(pickerdata: JsonDecoder().convert(PickerData)),
        hideHeader: true,
        title: new Text("Select Data"),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
        }
    ).showDialog(context);
  }
