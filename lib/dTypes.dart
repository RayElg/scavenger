import 'dart:convert';
import 'dart:math';

class Game {
  String id; //Random id for reference
  String title;
  List<String> tags; //Tag ids
  int numPlayers; //How many players?
  String description; //Author-provided description

  Game(String title, List<String> tags, String description) {
    this.title = title;
    this.tags = tags;
    this.numPlayers = 0;

    var rands = List<int>.generate(32, (i) => Random.secure().nextInt(255));
    this.id = base64Url.encode(rands);
  }
}

class Tag {
  String id;
  String title; //What is this object called?
  String tag; //What is the actual tag descriptor for this object
  String gameId;
  List<String> hasScored;
  Tag(String title, String tag) {
    this.title = title;
    this.tag = tag;
    this.hasScored = [];

    var rands = List<int>.generate(32, (i) => Random.secure().nextInt(255));
    this.id = base64Url.encode(rands);
  }
}

class User {
  String id;
  String name;
  User(String name) {
    this.name = name;
    var rands = List<int>.generate(32, (i) => Random.secure().nextInt(255));
    this.id = base64Url.encode(rands);
  }
}
