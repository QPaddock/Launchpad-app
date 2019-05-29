import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:launchpad_university_v2/screens/home.dart';
import 'package:launchpad_university_v2/color.dart';
import 'package:launchpad_university_v2/screens/profile.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _LoginPageState extends State<LoginPage> {
  
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget _child = Text(
                    'Lift Off!',
                    style: TextStyle(
                        color: myBackground,
                        fontSize: 15,
                  ));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              color: Color.fromRGBO(38, 0, 43, 1),
              height: 160,
              child: Column(
                children: <Widget>[
																	Padding(
																		padding: EdgeInsets.only(top: 20),
																		child: Image.asset('assets/Logo.PNG', scale: 2,),
																	),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Launchpad University',
                      style: TextStyle(
                          color: Color.fromRGBO(200, 200, 200, 1),
                          fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Text(
                      'Login!',
                      style: TextStyle(
                          color: Color.fromRGBO(200, 200, 200, 1),
                          fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 20),
              child: TextFormField(
                autofocus: true,
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Enter Email';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    gapPadding: 10.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 10),
              child: TextFormField(
                autofocus: true,
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Enter Password';
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    gapPadding: 10.0,
                  ),
                ),
                obscureText: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 130, right: 130),
              child: AnimatedContainer(
                duration: Duration(seconds: 3),
                child: FlatButton(
                  onPressed: sigIn,
                  color: myPrimaryColor,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20)),
                  child: _child,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

		@override
		void initState() {
			super.initState();
			getUser().then((user) {
				if (user != null){
					Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => profilePage()));
				}
			});
		}

		Future<FirebaseUser> getUser() async {
			return await _auth.currentUser();
		}

  Future<void> sigIn() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      try {
        setState(() {
									_child = Image.asset('assets/loading.gif', height: 20,);
        });
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => profilePage()));
      } catch (e) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
        return e.message;
      }
    }
  }
}
