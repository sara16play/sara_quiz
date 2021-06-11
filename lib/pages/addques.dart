import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/widgets.dart';
import 'package:random_string/random_string.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Myaddques extends StatefulWidget {
  //Myaddques({Key key}) : super(key: key);
  final String quizid;
  Myaddques(this.quizid);
  @override
  _MyaddquesState createState() => _MyaddquesState();
}

class _MyaddquesState extends State<Myaddques> {
  String ques, opt1, opt2, opt3, opt4;
  bool load = false;

  Future<void> addquest(Map quesdata, String quizid) async {
    setState(() {
      load = true;
    });
    await FirebaseFirestore.instance
        .collection("makequiz")
        .doc(quizid)
        .collection("question")
        .add(quesdata)
        .catchError((e) {
      print(e.toString());
    });
    setState(() {
      load = false;
    });
  }

  createques() async {
    setState(() {
      load = true;
    });
    Map<String, String> questionMap = {
      "question": ques,
      "option1": opt1,
      "option2": opt2,
      "option3": opt3,
      "option4": opt4,
    };
    await addquest(questionMap, widget.quizid);
    setState(() {
      load = false;
    });
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
                        ques = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Enter Question",
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
                        opt1 = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Option 1",
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
                        opt2 = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Option 2",
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
                        opt3 = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Option 3",
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
                        opt4 = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Option 4",
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
                  SizedBox(
                    height: 10,
                  ),
                  Material(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(32),
                      elevation: 10,
                      child: MaterialButton(
                        minWidth: 318,
                        child: Text("Submit",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 22)),
                        onPressed: () {
                          //await createquiz();
                          Navigator.pushReplacementNamed(context, "fquiz");
                        },
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Material(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(32),
                      elevation: 10,
                      child: MaterialButton(
                        minWidth: 318,
                        child: Text("Add question",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 22)),
                        onPressed: () async {
                          await Navigator.pushReplacementNamed(
                              context, "addques");
                        },
                      )),
                ])))));
  }
}
