import 'dart:convert';

import 'package:flutter/material.dart';
import 'dTypes.dart';
import 'gamePage.dart';
import 'package:scavenger/globals.dart' as global;
import 'profilePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    User u = new User("GUEST");
    global.setUser(u);
    global.memory.uTable[u.id] = u;
    global.memory.loadJson();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        title: 'Scavenger: Games',
        mem: global.memory,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.mem}) : super(key: key);
  final MainMem mem;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void callBack() {
    setState(() {
      global.memory.loadJson();
    });
  }

  void emptyCallBack() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    global.setMainSetState(callBack);
    global.mainEmptySetState = emptyCallBack;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [UserButton()],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: [
            SizedBox(width: 1, height: 8),
            Text("Active games:"),
            Expanded(
              child: ListView(
                children: [
                  for (Game g in widget.mem.gTable.values)
                    GameCard(g: g, mem: widget.mem),
                  IconButton(
                      icon: Icon(Icons.donut_small),
                      onPressed: () {
                        global.memory.loadJson();
                        setState(() {});
                      })
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: callBack,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class GameCard extends StatelessWidget {
  const GameCard({
    Key key,
    @required this.g,
    @required this.mem,
  }) : super(key: key);

  final Game g;
  final MainMem mem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        // Makes this container a button
        onLongPress: () {
          print("tap!");
          openGamePage(context, mem, g);
        },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              border: Border.all(),
              color: Colors.black12,
              borderRadius: BorderRadius.circular(4)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(g.title, style: TextStyle(fontSize: 18))],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text(g.tags.length.toString() + " tasks"),
                    SizedBox(width: 10),
                    Text(g.numPlayers(mem).toString() + " players"),
                    SizedBox(width: 10),
                    Text("Hosted by " + g.author),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                    g.getUserScore(mem, global.currentUser.id).toString() +
                        "/" +
                        g.getTotalScore(mem).toString(),
                    style: TextStyle(fontSize: 18))
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

class UserButton extends StatelessWidget {
  const UserButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              openProfilePage(context);
            }));
  }
}
