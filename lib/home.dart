import 'package:firstapp/quoteCard.dart';
import 'package:flutter/material.dart';
import 'quoteObject.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {

  QuoteProvider dbService = QuoteProvider();

  List<Quote> quotes = [
    Quote('Legend have fiston will finish the app','Fiston the gr8'),
    Quote('Stay Hungry, Stay Foolish','Steve Jobs'),
    Quote('An eye for an eye, makes the whole world blind', 'Ghandhi')
  ];

  void setUpQuotes() async{
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:true ,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text("My Quotes",style: TextStyle(fontWeight: FontWeight.w600,
                fontSize: 23, color: Colors.white),),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/steve_jobs.jpeg"),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(
            children: 
            quotes.map((quote) => QuoteCard(quote: quote,delete: (){
              setState(() {
                quotes.remove(quote);
              });
            } )
          ).toList()
          ),
        ),
      )
      );

  }
}




