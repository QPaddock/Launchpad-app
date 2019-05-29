import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:launchpad_university_v2/color.dart';
import 'package:launchpad_university_v2/screens/login.dart';
import '../widgets.dart';

class profilePage extends StatefulWidget {
  @override
  _profilePageState createState() => _profilePageState();
}

FirebaseAuth _auth = FirebaseAuth.instance;

class _profilePageState extends State<profilePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: myBackground,
        appBar: AppBar(
          elevation: 0.0,
          leading: Image.asset("assets/Logo.PNG", scale: 3.5,),
          title: Center(
            child: Text(
              "Launchpad University",
              style: TextStyle(color: myBackground),
            ),
          ),
          actions: <Widget>[
            IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: myBackground,
            ),
            onPressed: Logout,
            splashColor: myAccentColor,
          )
          ],
          bottom: TabBar(
            indicatorColor: myBackground,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.notifications), text: "Notifications",),
              Tab(icon: Icon(Icons.account_circle), text: "Profile",),
              Tab(icon: Icon(Icons.settings), text: "Settings",),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Noti(),
            student(),
            settings(),
          ],),
      ),
    );
  }
  Future<void> Logout() async {
    await _auth.signOut().then((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }
}

