import 'package:flutter/material.dart';
import 'package:scavenger/globals.dart';
import 'dTypes.dart';

void openProfilePage(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => ProfilePage()));
}

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login/Register")),
      body: Column(children: [
        Row(
          children: [Text("Login or Register")],
        ),
        SizedBox(height: 15),
        Text("Logged in as: ${currentUser.name}"),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Username: "),
            SizedBox(
                width: 210,
                child: Expanded(
                    child: TextField(
                  controller: controller,
                )))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RaisedButton(
                onPressed: () {
                  String matchingUser = memory.uTable.keys.firstWhere(
                      (element) =>
                          memory.uTable[element].name == controller.text,
                      orElse: () {
                    return "";
                  });
                  if (matchingUser != "") {
                    currentUser = memory.uTable[matchingUser];
                    mainSetState();
                    setState(() {});
                  }
                },
                child: Text("Login")),
            SizedBox(width: 15),
            RaisedButton(
                onPressed: () {
                  String matchingUser = memory.uTable.keys.firstWhere(
                      (element) =>
                          memory.uTable[element].name == controller.text,
                      orElse: () {
                    return "";
                  });
                  if (matchingUser == "") {
                    User u = User(controller.text);
                    currentUser = u;
                    memory.uTable[u.id] = u;
                    mainSetState();
                    setState(() {});
                  }
                },
                child: Text("Register")),
            SizedBox(width: 15),
          ],
        ),
      ]),
    );
  }
}
