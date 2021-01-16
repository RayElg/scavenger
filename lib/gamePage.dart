import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scavenger/dTypes.dart';

openGamePage(context, mem, g) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => GamePage(mem: mem, g: g)));
}

class GamePage extends StatefulWidget {
  final Game g;
  final MainMem mem;
  GamePage({Key key, @required this.mem, @required this.g}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.g.title)),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  widget.g.title,
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("0/" + widget.g.getTotalScore(widget.mem).toString(),
                    style: TextStyle(fontSize: 18))
              ],
            ),
            SizedBox(height: 18),
            Expanded(
              child: ListView(
                children: [
                  RichText(
                    text: TextSpan(
                      text: widget.g.description,
                      style: TextStyle(color: Colors.black54, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38),
                          shape: BoxShape.circle),
                      child: IconButton(
                          icon: Icon(Icons.camera_alt), onPressed: () {})),
                  SizedBox(height: 20),
                  Text("Tags to find: "),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        for (String t in widget.g.tags)
                          Container(
                            child: Column(children: [
                              Divider(),
                              Row(
                                children: [
                                  Text(
                                    widget.mem.tTable[t].title +
                                        " - " +
                                        widget.mem.tTable[t].value.toString(),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
