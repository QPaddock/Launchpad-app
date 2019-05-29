import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:launchpad_university_v2/color.dart';
import 'package:launchpad_university_v2/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

FirebaseAuth _auth = FirebaseAuth.instance;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment(1.2, 0.0),
          child: Text('Logout',
              style: TextStyle(color: myBackground, fontSize: 10)),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: myBackground,
            ),
            onPressed: Logout,
          )
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            color: myPrimaryColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  FutureBuilder(
                    future: FirebaseAuth.instance.currentUser(),
                    builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
                      if (snapshot.hasData) {
                        return StreamBuilder(
                          stream: Firestore.instance
                              .collection('users')
                              .document(snapshot.data.uid)
                              .snapshots(),
                          builder: (context, snapshots) {
                            if (!snapshots.hasData)
                              return Image.asset('assets/loading.gif');
                            var name = snapshots.data;
                            return Text(
                              name["student"],
                              style:
                                  TextStyle(color: myBackground, fontSize: 30),
                            );
                          },
                        );
                      } else {
                        return Image.asset('assets/loading.gif');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: myAccentColor,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Account Status',
                  style: TextStyle(color: myBackground, fontSize: 20),
                ),
              ),
            ),
          ),
          Container(
            child: FutureBuilder(
                    future: FirebaseAuth.instance.currentUser(),
                    builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
                      if (snapshot.hasData) {
                        return StreamBuilder(
                          stream: Firestore.instance
                              .collection('stat')
                              .document(snapshot.data.uid)
                              .snapshots(),
                          builder: (context, snapshots) {
                            if (!snapshots.hasData)
                              return Image.asset('assets/loading.gif');
                            var stat = snapshots.data;
                            return Text(
                              stat['status'],
                              style:
                                  TextStyle(color: myPrimaryColor, fontSize: 20),
                            );
                          },
                        );
                      } else {
                        return Image.asset('assets/loading.gif');
                      }
                    },
                  ),
          ),
          Container(
            color: myAccentColor,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Account Status',
                  style: TextStyle(color: myBackground, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
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
