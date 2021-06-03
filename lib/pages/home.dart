import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:delayed_display/delayed_display.dart';

class MyHome extends StatefulWidget {
  //name({Key key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  bool load = false;
  var controller1;
  var animation1;
  var auth = FirebaseAuth.instance;

  final gooleSignIn = GoogleSignIn();

  googleSignIn() async {
    try {
      setState(() {
        load = true;
      });

      GoogleSignInAccount? googleSignInAccount = await gooleSignIn.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        var result = await auth.signInWithCredential(credential);

        var user = await auth.currentUser!;
        print(user.uid);

        Navigator.pushReplacementNamed(context, "quiz");
        setState(() {
          load = false;
        });
        return Future.value(true);
      }
    } catch (e) {
      setState(() {
        load = false;

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Please check your Internet connection.."),
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
      });
    }
  }

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   //  fd();
  //   controller1 = AnimationController(
  //     vsync: this,
  //     duration: Duration(seconds: 0),
  //   );
  //   animation1 = CurvedAnimation(parent: controller1, curve: Curves.bounceInOut)
  //     ..addListener(() {
  //       setState(() {
  //         // animation = animation.value;
  //       });
  //     });
  //   controller1.forward();
  // }

  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(Colors.grey[700]);
    return Scaffold(
        //backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Home",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          leading: Icon(
            Icons.home,
            color: Colors.red,
            size: 25,
          ),
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
                      width: 230,
                      child: Image(
                        image: AssetImage("images/q3.png"),
                        fit: BoxFit.contain,
                      )),

                  SizedBox(height: 0),
                  Text(
                    "Welocome to",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  RichText(
                      text: TextSpan(
                          text: "SaraPlay ",
                          style: TextStyle(
                              fontSize: 29,
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
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Row(
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
                                Navigator.pushReplacementNamed(context, "reg");
                              },
                              child: Text("REGISTER",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
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
                                Navigator.pushReplacementNamed(
                                    context, "login");
                                setState(() {
                                  load = false;
                                });
                              },
                              child: Text("LOGIN",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 20,
                                  )),
                            )),
                      ]),
                  SizedBox(
                    height: 25,
                  ),
                  SignInButton(
                    Buttons.GoogleDark,
                    text: "Sign up with Google",
                    onPressed: () => googleSignIn().whenComplete(() async {
                      // setState(() {
                      //   load = true;
                      // });
                      //var user = await FirebaseAuth.instance.currentUser;
                    }),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  //)
                ],
              ),
            ),
          ),
        ));
  }
}
