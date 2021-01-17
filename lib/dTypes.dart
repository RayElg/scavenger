import 'dart:convert';
import 'dart:math';
import 'reqs.dart' as reqs;
import 'globals.dart' as global;

class Game {
  String id; //Random id for reference
  String title;
  List<String> tags; //Tag ids
  //int numPlayers; //How many players?
  String description; //Author-provided description
  String author;

  Game(String title, List<String> tags, String description,
      {this.id = "B", this.author = ""}) {
    this.title = title;
    this.tags = tags;
    //this.numPlayers = 0;
    this.description = description;
    if (this.id == "B") {
      var rands = List<int>.generate(32, (i) => Random.secure().nextInt(255));
      this.id = base64Url.encode(rands);
    }
  }

  int numPlayers(MainMem mem) {
    List<int> tagPlayers = [];
    for (String tag in this.tags) {
      tagPlayers.add(mem.tTable[tag].hasScored.length);
    }
    return tagPlayers.reduce(max);
  }

  int getTotalScore(MainMem mem) {
    int score = 0;
    for (String t in this.tags) {
      if (mem.tTable.containsKey(t)) {
        score += mem.tTable[t].value;
      }
    }
    return score;
  }

  int getUserScore(MainMem mem, String uId) {
    int score = 0;
    for (String t in this.tags) {
      if (mem.tTable.containsKey(t)) {
        if (mem.tTable[t].hasScored.contains(uId)) {
          score += mem.tTable[t].value;
        } else {
          print(mem.tTable[t].hasScored.toString() + " NOT EQUALS: " + uId);
        }
      }
    }
    return score;
  }
}

class Tag {
  String id;
  String title; //What is this object called?
  String tag; //What is the actual tag descriptor for this object
  String gameId;
  Set<String> hasScored;
  int value;
  Tag(String title, String tag, int value, {this.id = "B"}) {
    this.title = title;
    this.tag = tag;
    this.hasScored = {};
    this.value = value;
    if (this.id == "B") {
      var rands = List<int>.generate(32, (i) => Random.secure().nextInt(255));
      this.id = base64Url.encode(rands);
    }
  }
}

class User {
  String id;
  String name;
  User(String name, {this.id = "B"}) {
    this.name = name;
    if (this.id == "B") {
      var rands = List<int>.generate(32, (i) => Random.secure().nextInt(255));
      this.id = base64Url.encode(rands);
    }
  }
}

class MainMem {
  //For lack of a better term off the top of my head. This will hold all the tags, users, games in hashmaps
  //This will make it easy to refer to by value.
  //Later we will integrate this with cockroachDB
  Map<String, Game> gTable;
  Map<String, Tag> tTable;
  Map<String, User> uTable;
  MainMem() {
    this.gTable = new Map<String, Game>();
    this.tTable = new Map<String, Tag>();
    this.uTable = new Map<String, User>();
    //loadJson();
  }

  Future<void> loadJson() async {
    final ret = await reqs.getTables();

    final List users = ret["users"];
    users.forEach((element) {
      User u = User(element["name"], id: element["id"]);
      print("ID: " + element["id"]);
      this.uTable[u.id] = u;
      print("${u.name}: ${u.id}");
    });

    final List tags = ret["tags"];
    tags.forEach((element) {
      if (!this.tTable.containsKey(element["id"])) {
        Tag t = Tag(element["title"].replaceAll("-", " "),
            element["tag"].replaceAll("-", " "), element["value"],
            id: element["id"]);

        t.hasScored = (element["hasScored"].length > 0)
            ? element["hasScored"].split(",").toSet()
            : new Set();
        print(
            "hasScored: " + element["hasScored"].split(",").toSet().toString());
        print("T id:" + t.id);
        this.tTable[t.id] = t;
      } else {
        this
            .tTable[element["id"]]
            .hasScored
            .addAll(element["hasScored"].split(",").toSet());
      }
    });

    final List games = ret["games"];
    games.forEach((element) {
      print(element["tags"]);
      Game g = Game(
          element["title"].replaceAll("-", " "),
          element["tags"].split(","),
          element["description"].replaceAll("-", " "),
          id: element["id"],
          author: element["host"]);
      this.gTable[g.id] = g;
    });

    print(users);
    global.mainEmptySetState();
  }
}
