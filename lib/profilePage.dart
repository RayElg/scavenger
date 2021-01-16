import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login/Register")),
      body: Column(children: [
        Row(
          children: [Text("Login or Register")],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Username: "),
            SizedBox(width: 210, child: Expanded(child: TextField()))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RaisedButton(onPressed: () {}, child: Text("Login")),
            SizedBox(width: 15),
            RaisedButton(onPressed: () {}, child: Text("Register")),
            SizedBox(width: 15),
          ],
        ),
      ]),
    );
  }
}
