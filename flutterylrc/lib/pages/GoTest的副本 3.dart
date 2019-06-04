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
      body: //通过ConstrainedBox来确保Stack占满屏幕
        Column(
      children: <Widget>[
        Expanded(
          flex: 2, // 20%
          child: Container(color: Colors.red),
        ),
        Expanded(
          flex: 6, // 60%
          child: Container(color: Colors.green),
        ),
        Expanded(
          flex: 2, // 20%
          child: Container(color: Colors.blue),
        )
      ],
    )
    );
  }
}
