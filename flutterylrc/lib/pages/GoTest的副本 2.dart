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
        ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            alignment:Alignment.center , //指定未定位或部分定位widget的对齐方式
            fit: StackFit.expand,//未定位widget占满Stack整个空间
            children: <Widget>[
              Container(child: Text("Hello world",style: TextStyle(color: Colors.white)),
                // color: Colors.red,
              ),
              Positioned(
                left: 0.0,
                top:0,
                child: Container(
                  width:100,
                  color: Colors.black12,
                  alignment: Alignment.centerLeft,   
                  padding: const EdgeInsets.only(top:6.0,left:12.0,right:6.0,bottom:6.0),
                  child: RichText(    
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),            
                      children: <TextSpan>[
                        TextSpan(
                          text: '剩余时间:'
                        ),
                        TextSpan(
                          style:TextStyle(
                            color: Colors.redAccent,
                          ),
                          text: "38''09'",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 18.0,
                child: Text("Your friend"),
              )        
            ],
          ),
        )
    );
  }
}
