import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sara_quiz/pages/addques.dart';
import 'package:sara_quiz/pages/home.dart';
import 'package:sara_quiz/pages/login.dart';
import 'package:sara_quiz/pages/reg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sara_quiz/pages/quiz.dart';
import 'package:sara_quiz/pages/fquiz.dart';
import 'package:random_string/random_string.dart';
import 'package:sara_quiz/pages/quizhome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  String quizid;
//  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  quizid = randomAlphaNumeric(16);

  runApp(MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: "home",
      routes: {
        "home": (context) => MyHome(),
        "reg": (context) => MyReg(),
        "login": (context) => MyLogin(),
        "quiz": (context) => Myquiz(),
        "fquiz": (context) => MyfinalQ(quizid),
        "addques": (context) => Myaddques(quizid),
        "quizhome": (context) => Myquizhome(),
      }));
}
