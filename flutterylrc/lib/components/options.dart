// import 'package:flutter/material.dart';
// class NewRouteGoTest extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() =>new _CheckBoxListState();
// }

//   // final TextStyle aboutTextStyle = TextStyle(
//   //         color: Colors.black,
//   //         decoration: TextDecoration.underline,
//   //         decorationColor: Colors.red,
//   //         decorationStyle: TextDecorationStyle.wavy,
//   //       );
// class _CheckBoxListState extends State{
//   //初始化全部复选框按钮默认都是false    
//   List<bool> checkedList=[false,false,false,false];
//   void updateCheckboxStatus(int position,bool isCheck){
//     setState(() {
//       checkedList[position]=isCheck;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("试卷"),
//       ),
//       body: //通过ConstrainedBox来确保Stack占满屏幕
//         ConstrainedBox(
//           constraints: BoxConstraints.expand(),
//           child: Stack(
//             alignment:Alignment.topLeft , //指定未定位或部分定位widget的对齐方式
//             fit: StackFit.expand,//未定位widget占满Stack整个空间
//             children: <Widget>[
//               Container(
//                 padding: const EdgeInsets.only(top: 80.0, bottom: 4.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: const EdgeInsets.only(top: 8.0, bottom: 4.0,left:20),
//                       alignment: Alignment.centerLeft,
//                       child:Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Container(
//                             padding: const EdgeInsets.only(top: 8.0, bottom: 4.0,left:20),
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               '3.运行此项目的基础环境是？', 
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 18,
//                                 ), 
//                               ),
//                             ),
//                             Container(
//                               padding:const EdgeInsets.only(top: 8.0, bottom: 4.0),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: <Widget>[
//                                   //我用IOS模拟器测试的时候,不设置亲和力,默认值是platform，按钮展示在文字后面,很丑啊
//                                   new CheckboxListTile(controlAffinity:ListTileControlAffinity.leading,title:new Text('jdk'),value: checkedList[0], onChanged: (bool)=>updateCheckboxStatus(0,bool)),
//                                   new CheckboxListTile(controlAffinity:ListTileControlAffinity.leading,title:new Text('ellipsis'),value: checkedList[1], onChanged: (bool)=>updateCheckboxStatus(1,bool)),
//                                   new CheckboxListTile(controlAffinity:ListTileControlAffinity.leading,title:new Text('tomcat'),value: checkedList[2], onChanged: (bool)=>updateCheckboxStatus(2,bool)),
//                                   new CheckboxListTile(controlAffinity:ListTileControlAffinity.leading,title:new Text('mysql'),value: checkedList[3], onChanged: (bool)=>updateCheckboxStatus(3,bool)),
//                                 ],
//                               ),
//                             ),
//                           ])
//                         ),
//                     Container(
//                       padding: const EdgeInsets.only(top: 8.0, bottom: 4.0,left:20),
//                       alignment: Alignment.centerLeft,
//                       child:Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Container(
//                             padding: const EdgeInsets.only(top: 8.0, bottom: 4.0,left:20),
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               '4.运行此项目的基础环境是？(单选)', 
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 18,
//                                 ), 
//                               ),
//                             ),
//                             Container(
//                               padding:const EdgeInsets.only(top: 8.0, bottom: 4.0),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: <Widget>[
//                                   //我用IOS模拟器测试的时候,不设置亲和力,默认值是platform，按钮展示在文字后面,很丑啊
//                                   new RadioListTile<int>(
//                                     title: const Text('张三'),
//                                     value: 0,
//                                     groupValue: groupValue,
//                                     onChanged: (int e)=>updateGroupValue(e),
//                                   ),
//                                   new RadioListTile<int>(
//                                     title: const Text('李四'),
//                                     value: 1,
//                                     groupValue: groupValue,
//                                     onChanged: (int e)=>updateGroupValue(e),
//                                   ),
//                                   new RadioListTile<int>(
//                                     title: const Text('王五'),
//                                     value: 2,
//                                     groupValue: groupValue,
//                                     onChanged: (int e)=>updateGroupValue(e),
//                                   ),
//                                   new RadioListTile<int>(
//                                     title: const Text('张三'),
//                                     value: 3,
//                                     groupValue: groupValue,
//                                     onChanged: (int e)=>updateGroupValue(e),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ])
//                         ),
//                     Container(
//                       padding:const EdgeInsets.only(top: 8.0, bottom: 4.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           RaisedButton(
//                             padding: EdgeInsets.all(12.0),
//                             child: Text("上一题"),
//                             color: Theme
//                                 .of(context)
//                                 .primaryColor,
//                             textColor: Colors.white,
//                             onPressed: () {
                              
//                             },
//                           ),
//                           Container(
//                             padding: const EdgeInsets.only(left:30.0),
//                             child: RaisedButton(
//                               padding: EdgeInsets.all(12.0),
//                               child: Text("下一题"),
//                               color: Theme
//                                   .of(context)
//                                   .primaryColorDark,
//                               textColor: Colors.white,
//                               onPressed: () {
                                
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 // style: TextStyle(color: Colors.black)),

//                 // color: Colors.red,
//               ),
//             ],
//           ),
//         )
//     );
//   }
// }
