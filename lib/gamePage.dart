import 'dart:ui';
import 'cameraPage.dart';
import 'package:flutter/material.dart';
import 'package:scavenger/dTypes.dart';
import 'package:scavenger/globals.dart';

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
  callBack() {
    setState(() {
      print(l.toString());
      for (String t in widget.g.tags) {
        if (l.contains(widget.mem.tTable[t].tag.toUpperCase())) {
          print("Match!" + widget.mem.tTable[t].tag.toUpperCase());
          widget.mem.tTable[t].hasScored.add(currentUser.id);
        } else {
          print("No match: " + widget.mem.tTable[t].tag.toUpperCase());
        }
      }
      mainSetState();
    });
  }

  List<String> l = [];
  @override
  Widget build(BuildContext context) {
    setGamePageSetState(callBack);
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
                Text(
                    widget.g
                            .getUserScore(widget.mem, currentUser.id)
                            .toString() +
                        "/" +
                        widget.g.getTotalScore(widget.mem).toString(),
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
                          icon: Icon(Icons.camera_alt),
                          onPressed: () {
                            openCameraPage(
                                context, widget.mem, widget.g, l, callBack);
                          })),
                  SizedBox(height: 10),
                  SizedBox(
                      height: 15,
                      child: ListView(
                        children: [Text(l.toString())],
                        scrollDirection: Axis.horizontal,
                      )),
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
                                  Icon(widget.mem.tTable[t].hasScored
                                          .contains(currentUser.id)
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank),
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
