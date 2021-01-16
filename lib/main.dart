import 'package:flutter/material.dart';
import 'dTypes.dart';
import 'gamePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Scavenger: Games'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  MainMem mem = new MainMem();
  final String title;
  User u = new User("raynor");
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
    Tag a = new Tag("Chapeau", "hat", 17);
    widget.mem.tTable[a.id] = a;
    Game g =
        new Game("Scavenger Hunt!", [a.id], "Its a scavenger hunt, of course!");

    a.gameId = g.id;
    print(g.id);
    widget.mem.gTable[g.id] = g;
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
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
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
              border: Border(), color: Color.fromARGB(100, 255, 50, 255)),
          child: Row(children: [
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
                    Text(g.numPlayers.toString() + " players"),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("0/" + g.getTotalScore(mem).toString(),
                    style: TextStyle(fontSize: 18))
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
