import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  Widget borderTextField() {
//    return Theme(
//      data: ThemeData(primaryColor: Colors.blue, hintColor: Colors.red),
//      child: TextField(
//        decoration: InputDecoration(
//            contentPadding: EdgeInsets.all(15.0),
//            border: OutlineInputBorder(
//                borderRadius: BorderRadius.circular(8.0),
//                // 下面方法无效
////                borderSide: BorderSide(color: Colors.red, width: 10.0, style: BorderStyle.solid)
//            )
//        ),
//      ),
//    );

    return Container(
      padding: const EdgeInsets.all(5.0),
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.white70,
        border: Border.all(color: Colors.yellow, width: 5.0),
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: TextFormField(
        decoration: InputDecoration.collapsed(hintText: '请输入内容'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Text('Home'),
//        child: Padding(
//          padding: const EdgeInsets.all(15.0),
//          child: borderTextField(),
//        ),
      ),
    );
  }
}
