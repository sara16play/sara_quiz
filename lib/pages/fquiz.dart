import 'dart:core';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sara_quiz/pages/addques.dart';

class MyfinalQ extends StatefulWidget {
  //MyfinalQ({Key key}) : super(key: key);
  final String quizid;
  MyfinalQ(this.quizid);
  @override
  _MyfinalQState createState() => _MyfinalQState();
}

class _MyfinalQState extends State<MyfinalQ> {
  Future<void> adddata(Map quizdata, String quizid) async {
    await FirebaseFirestore.instance
        .collection("makequiz")
        .doc(quizid)
        .set(quizdata)
        .catchError((e) {
      print(e.toString());
    });
  }

  String imageurl, quizdesc, quizname;
  bool load = false;

  createquiz() async {
    setState(() {
      load = true;
    });
    Map<String, String> quizMap = {
      "quizid": widget.quizid,
      "imageurl": imageurl,
      "quizname": quizname,
      "quizdesc": quizdesc
    };
    await adddata(quizMap, widget.quizid);
    setState(() {
      load = false;
    });
    Navigator.pushReplacementNamed(context, "addques");
  }

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
                  Container(
                    width: 320,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      autocorrect: false,
                      onChanged: (value) {
                        imageurl = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Enter Image URL",
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
                    height: 10,
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
                        quizname = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Enter QUIZ Name",
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
                  Container(
                    width: 320,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      autocorrect: false,
                      onChanged: (value) {
                        quizdesc = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Enter Quiz Description",
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
                  Material(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(32),
                      elevation: 10,
                      child: MaterialButton(
                        minWidth: 318,
                        child: Text("Create QUIZ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 22)),
                        onPressed: () async {
                          await createquiz();
                        },
                      )),
                  Material(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(32),
                      elevation: 10,
                      child: MaterialButton(
                        minWidth: 318,
                        child: Text("Show Quiz",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 22)),
                        onPressed: () async {
                          await Navigator.pushReplacementNamed(
                              context, "quizhome");
                        },
                      )),
                ])))));
  }
}
