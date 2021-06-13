import 'package:flutter/material.dart';

class Quizques extends StatefulWidget {
  //Quizques({Key? key}) : super(key: key);

  final String quizid;
  Quizques(this.quizid);

  @override
  _QuizquesState createState() => _QuizquesState();
}

class _QuizquesState extends State<Quizques> {
  @override
  void initState() {
    print("${widget.quizid}");

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.red),
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
        body: SingleChildScrollView(
          child: Text("${widget.quizid}"),
        ));
  }
}
