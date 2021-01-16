import 'dart:convert';
import 'dart:math';

import 'package:flutter/rendering.dart';

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
    this.description = description;

    var rands = List<int>.generate(32, (i) => Random.secure().nextInt(255));
    this.id = base64Url.encode(rands);
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
}

class Tag {
  String id;
  String title; //What is this object called?
  String tag; //What is the actual tag descriptor for this object
  String gameId;
  List<String> hasScored;
  int value;
  Tag(String title, String tag, int value) {
    this.title = title;
    this.tag = tag;
    this.hasScored = [];
    this.value = value;

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

class MainMem {
  //For lack of a better term off the top of my head. This will hold all the tags, users, games in hashmaps
  //This will make it easy to refer to by value.
  //Later we will integrate this with cockroachDB
  Map<String, Game> gTable;
  Map<String, Tag> tTable;
  MainMem() {
    this.gTable = new Map<String, Game>();
    this.tTable = new Map<String, Tag>();
  }
}
