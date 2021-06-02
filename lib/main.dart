import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sara_quiz/pages/home.dart';
import 'package:sara_quiz/pages/login.dart';
import 'package:sara_quiz/pages/reg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sara_quiz/pages/quiz.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: "home",
      routes: {
        "home": (context) => MyHome(),
        "reg": (context) => MyReg(),
        "login": (context) => MyLogin(),
        "quiz": (context) => Myquiz(),
      }));
}
