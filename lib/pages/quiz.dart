import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

class Myquiz extends StatefulWidget {
  //Myquiz({required Key key}) : super(key: key);

  @override
  _MyquizState createState() => _MyquizState();
}

FirebaseAuth auth = FirebaseAuth.instance;
final gooleSignIn = GoogleSignIn();

class _MyquizState extends State<Myquiz> {
  bool load = false;
  var controller1;
  var animation1;
  var dn = auth.currentUser.displayName;
  var de = auth.currentUser.email;
  //var user = GoogleSignInAccount.currentUser;
  //var result = (await auth.signInWithCredential(credential)).user;
  var users;
  var ds;

  signOutUser() async {
    try {
      setState(() {
        load = true;
      });
      users = await auth.currentUser;
      print(users.providerData[0].providerId);
      if (users.providerData[0].providerId == 'google.com') {
        await gooleSignIn.disconnect();
        print("done");
        setState(() {
          load = false;
        });
      }
      await auth.signOut();
      print("donewithourgoogle");
      setState(() {
        load = false;
      });
      Navigator.pushReplacementNamed(context, "home");
      return Future.value(true);
    } catch (e) {
      setState(() {
        load = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please check your Internet Connection"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"))
            ],
          );
        },
      );
    }
  }

  googleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await gooleSignIn.signIn();

    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      //user = (await _auth.signInWithCredential(credential)).user;

      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      var result = (await auth.signInWithCredential(credential)).user;
      //print(await result);
      users = await auth.currentUser;
      //print(users.uid);
      return await result;
      //return Future.value(result.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.home_filled, color: Colors.red),
                onPressed: () async {
                  Navigator.pushReplacementNamed(context, "home");
                }),
          ],
          centerTitle: true,
          title: RichText(
              text: TextSpan(
                  text: "SaraPlay ",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent[700]),
                  children: <TextSpan>[
                TextSpan(
                  text: "QUIZ",
                  style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                )
              ])),
          backgroundColor: Colors.black,
        ),
        body: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(),
          inAsyncCall: load,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                      height: 200,
                      // width: 230,
                      child: Image(
                        image: AssetImage("images/q6.png"),
                        fit: BoxFit.contain,
                      )),

                  SizedBox(height: 20),

                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        if (dn == null) ...[
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'You are signed is as:\n',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                  text: '${de}\n',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900,
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue),
                                ),
                                TextSpan(
                                  text:
                                      'Continue to quiz or logout and sign in with Correct User..',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'You are signed is as:\n',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                  text: '${dn}\n',
                                  style: TextStyle(
                                      fontSize: 25,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.blue),
                                ),
                                TextSpan(
                                  text:
                                      'Continue to quiz or logout and sign in with Correct User..',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  /*RichText(
                      text: TextSpan(
                          text: "",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          children: <TextSpan>[
                        TextSpan(
                          text: " Sara Play QUIZ",
                          style: TextStyle(
                              fontSize: 29,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent[700]),
                        )
                      ])),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Where you can test your knowledge",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrangeAccent[700]),
                  ),
                  SizedBox(
                    height: 20,
                  ),*/

                  SizedBox(
                    height: 20,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Material(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(32),
                            elevation: 10,
                            child: MaterialButton(
                              minWidth: 150,
                              onPressed: () {
                                signOutUser();
                              },
                              child: Text("LOGOUT",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent[700],
                                    fontSize: 20,
                                  )),
                            )),
                        //),
                        SizedBox(height: 35),
                        // DelayedDisplay(
                        // delay: Duration(seconds: 0),
                        //child:
                        Material(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(32),
                            elevation: 10,
                            child: MaterialButton(
                              minWidth: 150,
                              onPressed: () {
                                setState(() {
                                  load = true;
                                });
                                //print(googleSignIn());
                                Navigator.pushReplacementNamed(
                                    context, "fquiz");
                                setState(() {
                                  load = false;
                                });
                              },
                              child: Text("Continue >>",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent[700],
                                    fontSize: 20,
                                  )),
                            )),
                      ]),

                  SizedBox(
                    height: 25,
                  ),
                  // SignInButton(
                  //   Buttons.GoogleDark,
                  //   text: "Sign up with Google",
                  //   onPressed: () => googleSignIn().whenComplete(() async {
                  //     var user = await FirebaseAuth.instance.currentUser;
                  //     Navigator.pushReplacementNamed(context, "quiz");
                  //   }),
                  // ),
                  // SizedBox(
                  //   height: 30,
                  // ),

                  //)
                ],
              ),
            ),
          ),
        ));
  }
}
