import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sara_quiz/pages/addques.dart';
import 'package:firebase_core/firebase_core.dart';

class Myquizhome extends StatefulWidget {
  // Myquizhome({Key key}) : super(key: key);

  @override
  _MyquizhomeState createState() => _MyquizhomeState();
}

class _MyquizhomeState extends State<Myquizhome> {
  bool load = false;
  Future getquizdata() async {
    return await FirebaseFirestore.instance.collection("makequiz").snapshots();
  }

  Stream quizstr;
  Widget list() {
    return Container(
        child: Column(
      children: [
        StreamBuilder(
          stream: quizstr,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container();
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return Quizshow(
                      imgurl: snapshot.data.docs[index].data()["imageurl"],
                      title: snapshot.data.docs[index].data()["quizname"],
                      desc: snapshot.data.docs[index].data()["quizdesc"],
                    );
                  });
            }
          },
        ),
      ],
    ));
  }

  void initState() {
    getquizdata().then((val) {
      setState(() {
        quizstr = val;
      });
    });
    super.initState();
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
      body: SingleChildScrollView(
        child: list(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }
}

class Quizshow extends StatelessWidget {
  //const Quizshow({Key key}) : super(key: key);
  final String imgurl, title, desc;
  Quizshow({@required this.imgurl, @required this.title, @required this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Image.network(imgurl),
          Container(
            child: Column(
              children: [Text(title), Text(desc)],
            ),
          )
        ],
      ),
    );
  }
}
