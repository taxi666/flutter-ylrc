import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'pages/email_screen.dart';
import 'pages/pages_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _BottomNavigationColor = Colors.grey;
  int _currentIndex = 0;
  List<Widget> itemList = List();

  @override
  void initState() {
    itemList
    ..add(HomeScreen())
    ..add(EmailScreen())
    ..add(PagesScreen());
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: itemList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _BottomNavigationColor,
            ),
            title: Text('Home', style: TextStyle(color: _BottomNavigationColor))
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.email,
                color: _BottomNavigationColor,
              ),
              title: Text('Email', style: TextStyle(color: _BottomNavigationColor))
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.pages,
                color: _BottomNavigationColor,
              ),
              title: Text('Pages', style: TextStyle(color: _BottomNavigationColor))
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.lightBlue,
      ),
    );
  }
}

