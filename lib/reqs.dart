import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'auth.dart';

Future<List<dynamic>> getLabels(String b64) async {
  final jsonMap = {
    "requests": [
      {
        "image": {"content": b64},
        "features": [
          {"type": "LABEL_DETECTION", "maxResults": 10}
        ]
      }
    ]
  };

  String json = jsonEncode(jsonMap);

  final ret = await http.post(
      "https://vision.googleapis.com/v1/images:annotate?key=$TOKEN",
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: json);
  List<String> tagList = [];
  Map<String, dynamic> body = jsonDecode(ret.body);

  final annotations = body["responses"][0]["labelAnnotations"];

  for (Map<String, dynamic> ann in annotations) {
    tagList.add(ann["description"]);
  }

  print(ret.body);
  return tagList;
}

Future<Map<String, dynamic>> getTables() async {
  final ret = await http.get(
    "https://raynorelgie.com/scavenger/api.php?\"req\"=\"get\"",
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8"
    },
  );
}
