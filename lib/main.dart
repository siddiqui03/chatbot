import 'package:chatbot/consts.dart';
import 'package:chatbot/pages/intro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() {
  Gemini.init(apiKey: GEMINI_API_KEY);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zozo ChatBot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IntroPage(), // Starting the app with the IntroPage
    );
  }
}
