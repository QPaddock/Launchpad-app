import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'color.dart';

var v = 0.0;

Widget student() {
  return Column(
    children: [
      Stack(children: [
        Container(
          height: 100,
          color: myPrimaryColor,
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: FutureBuilder(
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
                              "Name: " + name["student"],
                              style:
                                  TextStyle(color: myBackground, fontSize: 15),
                            );
                          },
                        );
                      } else {
                        return Image.asset(
                          'assets/loading.gif',
                          height: 15,
                        );
                      }
                    },
                  ),
                ),
                Text(
                  'Studying: Web Design',
                  style: TextStyle(color: myBackground, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              width: 120.0,
              height: 120.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: myBackground,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 0.0),
                child: Icon(
                  Icons.account_circle,
                  size: 120.0,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(
                value: v,
              ),
            ),
          ),
        )
      ]),
      Expanded(
        child: ListView(
          children: [
            Center(
              child: Text(
                "Account Status:",
                style: TextStyle(fontSize: 25, color: myPrimaryColor),
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
                        get_stat(stat["status"]);
                        return Center(
                          child: Text(
                            stat["status"],
                            style:
                                TextStyle(color: myPrimaryColor, fontSize: 15),
                          ),
                        );
                      },
                    );
                  } else {
                    return Image.asset(
                      'assets/loading.gif',
                      scale: 2,
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    ],
  );
}

void get_stat(stat) {
  if (stat == "Email Sent") v = 0.12;
  if (stat == "Account Registered") v = 0.25;
  if (stat == "Application Started") v = 0.37;
  if (stat == "Application Received") v = 0.5;
  if (stat == "Application Reviewed") v = 0.75;
  if (stat == "Application Accepted") v = 1;
}

Widget Noti() {
  return ListView(children: [
    ListTile(
      leading: Icon(Icons.mail_outline),
      title: Text("Account Created"),
      subtitle: Text("25 March 2019"),
    ),
    ListTile(
      leading: Icon(Icons.mail_outline),
      title: Text("Account Verified"),
      subtitle: Text("26 March 2019"),
    ),
    ListTile(
      leading: Icon(Icons.mail_outline),
      title: Text("Account Registered"),
      subtitle: Text("29 March 2019"),
    ),
    ListTile(
      leading: Icon(Icons.mail_outline),
      title: Text("Application Started"),
      subtitle: Text("30 March 2019"),
    ),
    ListTile(
      leading: Icon(Icons.mail_outline),
      title: Text("Application Received"),
      subtitle: Text("30 March 2019"),
    ),
    ListTile(
      leading: Icon(Icons.mail),
      title: Text("Application Reviewed"),
      subtitle: Text("10 April 2019"),
    ),
  ]);
}

bool isOn = true;

Widget settings() {
  return ListView(
    children: <Widget>[
      ListTile(
        title: Text("Push Notifications", style: TextStyle(fontSize: 20),),
        trailing: Switch(
          value: isOn,
          onChanged: (value) {
            isOn = value;
          },
          activeTrackColor: myPrimaryColor,
          activeColor: myAccentColor,
          materialTapTargetSize: MaterialTapTargetSize.padded,
        ),
      )
    ],
  );
}
