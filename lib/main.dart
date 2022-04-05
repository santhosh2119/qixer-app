import 'package:flutter/material.dart';
import 'package:qixer/intro/introduction_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qixer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IntroductionPage(),
    );
  }
}
