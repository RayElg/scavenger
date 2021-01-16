import 'package:flutter/material.dart';

openGamePage(context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => GamePage()));
}

class GamePage extends StatefulWidget {
  final String title = "Game";
  GamePage({Key key}) : super(key: key);
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        child: Text("Hello!"),
      ),
    );
  }
}
