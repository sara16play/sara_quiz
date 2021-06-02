import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:modal_progress_hud/modal_progress_hud.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
//import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyReg extends StatefulWidget {
  //name({Key key}) : super(key: key);

  @override
  _MyRegState createState() => _MyRegState();
}

class _MyRegState extends State<MyReg> {
  late String email;
  late String pass;
  bool load = false;
  var user;
  var auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  showErrDialog(BuildContext context, String err) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(err),
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

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(Colors.grey[700]);
    return Scaffold(
      key: _scaffoldKey,
      //backgroundColor: Colors.grey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // actions: <Widget>[
        //   IconButton(
        //       icon: Icon(Icons.home_filled, color: Colors.red),
        //       onPressed: () async {
        //         Navigator.pushReplacementNamed(context, "home");
        //       }),
        // ],
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 54),
                  ),
                ),
                Center(
                  child: Text(
                    'Register to continue',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        TextField(
                          cursorColor: Colors.red,
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          enableSuggestions: false,
                          autocorrect: false,
                          onChanged: (value) {
                            email = value;
                          },
                          //decoration: textFieldDecor('Email', Icons.mail_outline),
                          decoration: InputDecoration(
                            //hintText: 'Enter Email',
                            //hintStyle: TextStyle(color: Colors.red[300]),
                            labelText: "Email",
                            labelStyle: TextStyle(
                              color: Colors.red,
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                            ),
                            icon: Icon(
                              Icons.mail_outline,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TextField(
                            cursorColor: Colors.red,
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
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
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
                            borderRadius: BorderRadius.circular(35),
                            elevation: 10,
                            child: MaterialButton(
                              minWidth: 318,
                              child: Text("Register",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 22,
                                  )),
                              onPressed: () async {
                                setState(() {
                                  load = true;
                                });
                                try {
                                  var user =
                                      await auth.createUserWithEmailAndPassword(
                                          email: email, password: pass);
                                  if (user.additionalUserInfo!.isNewUser ==
                                      true) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Successful"),
                                          content: Text(
                                              "Successfully Registered.. Please Login with same E-Mail and Password to continue.."),
                                          actions: <Widget>[
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.popAndPushNamed(
                                                      context, "home");
                                                },
                                                child: Text("OK"))
                                          ],
                                        );
                                      },
                                    );
                                    //Navigator.pushNamed(context, "home");
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
                        //   print(e.code);
                        //   setState(() {
                        //     load = false;
                        //   });
                        //   switch (e) {
                        //     case 'email-already-in-use':
                        //       showErrDialog(context, e.toString());
                        //       break;
                        //     case 'invalid-email':
                        //       showErrDialog(context, e.toString());
                        //       break;
                        //     case 'ERROR_USER_NOT_FOUND':
                        //       showErrDialog(context, e.toString());
                        //       break;
                        //     case 'ERROR_USER_DISABLED':
                        //       showErrDialog(context, e.toString());
                        //       break;
                        //     case 'ERROR_TOO_MANY_REQUESTS':
                        //       showErrDialog(context, e.toString());
                        //       break;
                        //     case 'ERROR_OPERATION_NOT_ALLOWED':
                        //       showErrDialog(context, e.toString());
                        //       break;
                        //   }
                        //   // since we are not actually continuing after displaying errors
                        //   // the false value will not be returned
                        //   // hence we don't have to check the valur returned in from the signin function
                        //   // whenever we call it anywhere
                        //   return Future.value(null);
                        // }

                        // showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return AlertDialog(
                        //       title: Text("Error"),
                        //       content: Text("$Error"),
                        //       actions: <Widget>[
                        //         FlatButton(
                        //             onPressed: () {
                        //               Navigator.of(context).pop();
                        //             },
                        //             child: Text("OK"))
                        //       ],
                        //     );
                        //   },
                        //  );
                        // })),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an Account? ',
                              style: TextStyle(color: Colors.redAccent[700]),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, "login");
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.redAccent[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
