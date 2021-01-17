import 'package:flutter/material.dart';
import 'dTypes.dart';
import 'globals.dart' as global;
import 'reqs.dart';

void openAddGamePage(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => AddGamePage()));
}

class AddGamePage extends StatefulWidget {
  AddGamePage({Key key}) : super(key: key);
  List<Widget> widgList = [
    TagWidget(),
  ];
  int numTags = 1;
  @override
  _AddGamePageState createState() => _AddGamePageState();
}

class _AddGamePageState extends State<AddGamePage> {
  TextEditingController titleCont = new TextEditingController();
  TextEditingController descCont = new TextEditingController();

  addTagWidget() {
    widget.widgList.add(TagWidget());
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgList = [
      Row(
        children: [
          Text("Title: "),
          SizedBox(width: 250, child: TextField(controller: titleCont))
        ],
      ),
      Row(
        children: [
          Text("Description: "),
          SizedBox(
              width: 250,
              child: TextField(
                controller: descCont,
              ))
        ],
      ),
    ];

    widgList.addAll(List.generate(widget.numTags, (int i) => new TagWidget()));

    return Scaffold(
      appBar: AppBar(title: Text("Add new game...")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Expanded(
            child: ListView(
              children: widgList,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            RaisedButton(
                onPressed: () {
                  setState(() {
                    widget.numTags += 1;
                  });
                },
                child: Text("Add another widget...")),
            RaisedButton(
                onPressed: () {
                  List<String> tags = [];
                  List<Tag> tObjects = [];
                  for (Widget widg in widgList) {
                    if (widg is TagWidget) {
                      tObjects.add(widg.getTag());
                    }
                  }
                  for (Tag t in tObjects) {
                    tags.add(t.id);
                    global.memory.tTable[t.id] = t;
                    addTag(t.title.replaceAll(" ", "-"),
                        t.tag.replaceAll(" ", "-"), t.hasScored, t.value, t.id);
                  }
                  Game g = new Game(titleCont.text, tags, descCont.text,
                      author: global.currentUser.name);
                  global.memory.gTable[g.id] = g;
                  addGame(g.id, g.title.replaceAll(" ", "-"),
                      g.description.replaceAll(" ", "-"), g.tags, g.author);
                },
                child: Text("Make Game!")),
          ]),
        ]),
      ),
    );
  }
}

class TagWidget extends StatefulWidget {
  TagWidget({Key key}) : super(key: key);

  Tag getTag() {
    Tag t = new Tag(titleCont.text, tagCont.text, int.parse(valueCont.text));
    return t;
  }

  TextEditingController tagCont = new TextEditingController();
  TextEditingController titleCont = new TextEditingController();
  TextEditingController valueCont = new TextEditingController();

  @override
  _TagWidgetState createState() => _TagWidgetState();
}

class _TagWidgetState extends State<TagWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Tag: "),
            Row(
              children: [
                Text("Title: "),
                SizedBox(
                    width: 220, child: TextField(controller: widget.titleCont)),
              ],
            ),
            Row(
              children: [
                Text("Tag: "),
                SizedBox(
                    width: 220, child: TextField(controller: widget.tagCont))
              ],
            ),
            Row(
              children: [
                Text("Value: "),
                SizedBox(
                    width: 220, child: TextField(controller: widget.valueCont))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
