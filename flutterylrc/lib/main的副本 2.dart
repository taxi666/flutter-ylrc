import 'package:flutter/material.dart';
// import 'pages/GoTest.dart';
import 'pages/TestCenter.dart';
import 'pages/login.dart';
import './globals.dart' as globals;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '猿来如此'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  int _counter = 0;
  void goCenter(){
    //导航到新路由   
      Navigator.push( context,
      new MaterialPageRoute(builder: (context) {
            return new FormTestRoute();
      }));
    }

  @override
  void initState() {
    print('initState');
    super.initState();
    // this.goCenter();
  }
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: 
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
            autofocus: true,
            decoration: InputDecoration(
                labelText: "账号",
                hintText: "登录账户",
                prefixIcon: Icon(Icons.person)
            ),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: "密码",
                hintText: "登录密码",
                prefixIcon: Icon(Icons.lock)
            ),
            obscureText: true,
          ),
          FlatButton(
            color: Colors.blue,
            highlightColor: Colors.blue[700],
            colorBrightness: Brightness.dark,
            splashColor: Colors.grey,
            child: Text("登录"),
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            onPressed: () => {},
          ),
            FlatButton(
            child: Text("考试中心"),
            textColor: Colors.blue,
            onPressed: () {
              //导航到新路由   
              Navigator.push( context,
              new MaterialPageRoute(builder: (context) {
                      return new NewRouteTestCenter();
                }));
              },
            ),
            FlatButton(
              child: Text("go login"),
              textColor: Colors.blue,
              onPressed: () {
              //导航到新路由   
                Navigator.push( context,
                new MaterialPageRoute(builder: (context) {
                      return new FormTestRoute();
                }));
              },
            ),
          ],
          
        ),
    
      
    );
  }
}


