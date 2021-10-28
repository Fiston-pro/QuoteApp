import 'package:firstapp/quoteCard.dart';
import 'package:flutter/material.dart';
import 'quoteObject.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {

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
      body: Container(
        constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/day.jpg"),
                        fit: BoxFit.cover)),
        child: Column(
          children: quotes.map((quote) => QuoteCard(quote: quote,delete: (){
            setState(() {
              quotes.remove(quote);
            });
          } )
        ).toList()
        ),
      )
      );

  }
}


