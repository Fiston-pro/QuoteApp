import 'package:firstapp/quoteCard.dart';
import 'package:flutter/material.dart';
import 'quoteObject.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: increment()
    );
  }
}

class increment extends StatefulWidget {
  const increment({Key? key}) : super(key: key);

  @override
  _incrementState createState() => _incrementState();
}

class _incrementState extends State<increment> {

  List<Quote> quotes = [
    Quote('Legend have fiston will finish the app','Fiston the gr8'),
    Quote('Thanks my son','Mom'),
    Quote('Welcome to our company', 'FAANG interviewer')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Center(child: Text('Quote App', style: TextStyle(
            color: Colors.white,fontSize: 25),),),
      ),
      body: Column(
        children: quotes.map((quote) => QuoteCard(quote: quote,delete: () {setState(){
          quotes.remove(quote);
        }})
      ).toList()
      )
      );

  }
}


