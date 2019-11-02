import 'package:flutter/material.dart';

class EmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email'),
        backgroundColor: Color.fromRGBO(108, 121, 219, 1.0), //导航栏和状态栏的的颜色

      ),
      body: Center(
        child: Text('Email'),
        
      ),
    );
  }
}