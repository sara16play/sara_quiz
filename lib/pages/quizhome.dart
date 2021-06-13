import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sara_quiz/pages/addques.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sara_quiz/pages/quizques.dart';

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
        margin: EdgeInsets.symmetric(horizontal: 21),
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
                          quizid: snapshot.data.docs[index].data()["quizid"],
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
  final String imgurl, title, desc, quizid;
  Quizshow(
      {@required this.imgurl,
      @required this.title,
      @required this.desc,
      @required this.quizid});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Quizques(quizid)));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // add this
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.network(imgurl,
                        // width: 300,
                        height: 150,
                        fit: BoxFit.cover),
                  ),
                  ListTile(
                    title: Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      desc,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        //Container(
        //height: 150,
        //margin: EdgeInsets.only(top: 10, bottom: 6),
        //child:
        // Stack(
        //   children: [
        //     Container(
        //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        //       child: Image.network(
        //         imgurl,
        //         width: MediaQuery.of(context).size.width - 42,
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //     Container(
        //       //color: Colors.black26,
        //       decoration: BoxDecoration(
        //         color: Colors.black26,
        //         //   image: DecorationImage(
        //         //     image: NetworkImage(imgurl),
        //         //     fit: BoxFit.cover,
        //         //   ),
        //         border: Border.all(
        //           color: Colors.red,
        //           width: 2,
        //         ),
        //         borderRadius: BorderRadius.circular(30),
        //       ),
        //       alignment: Alignment.center,
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text(
        //             title,
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 20,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           SizedBox(height: 5),
        //           Text(
        //             desc,
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 15,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ],
        //       ),
        //     )
        //   ],
        // ),
      ],
    ));
  }
}
