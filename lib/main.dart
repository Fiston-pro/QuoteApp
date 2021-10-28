import 'package:firstapp/quoteCard.dart';
import 'package:flutter/material.dart';
import 'quoteObject.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: home()
    );
  }
}

