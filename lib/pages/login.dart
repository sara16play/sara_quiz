import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:modal_progress_hud/modal_progress_hud.dart';
//import 'package:sara_quiz/pages/home.dart';
//import 'package:delayed_display/delayed_display.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyLogin extends StatefulWidget {
  //name({Key key}) : super(key: key);

  @override
  _MyRegState createState() => _MyRegState();
}

class _MyRegState extends State<MyLogin> {
  late String email, pass;
  bool load = false;
  //GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // key: _scaffoldKey,
        //backgroundColor: Colors.blueGrey,
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
          progressIndicator: CircularProgressIndicator.adaptive(),
          inAsyncCall: load,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 54,
                    ),
                  ),
                  Text(
                    'Login to continue',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 320,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      autocorrect: false,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.red),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        icon: Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 320,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      obscuringCharacter: "*",
                      onChanged: (value) {
                        pass = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Password',
                        labelStyle: TextStyle(color: Colors.red),
                        //labelText: "Password",
                        //labelStyle: TextStyle(color: Colors.red),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        icon: Icon(
                          Icons.lock_outline,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Material(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(32),
                      elevation: 10,
                      child: MaterialButton(
                        minWidth: 318,
                        child: Text("Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 22)),
                        onPressed: () async {
                          setState(() {
                            load = true;
                          });
                          try {
                            var signin = await auth.signInWithEmailAndPassword(
                                email: email, password: pass);

                            if (signin != null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("successful"),
                                    content: Text("$Error"),
                                    actions: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.popAndPushNamed(
                                                context, "quiz");
                                          },
                                          child: Text("OK"))
                                    ],
                                  );
                                },
                              ); //Navigator.pushReplacementNamed(context, "quiz");
                              setState(() {
                                load = false;
                              });
                            }
                          } catch (e) {
                            setState(() {
                              load = false;

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(
                                        "Please check your Email and Password.."),
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
                          //print(user);
                        },
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an Account?   ',
                        style: TextStyle(color: Colors.redAccent[700]),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "reg");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.redAccent[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //),
          ),
          //),
          //)
        ));
  }
}
