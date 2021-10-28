
import 'package:flutter/material.dart';
import 'quoteObject.dart';

class QuoteCard extends StatelessWidget {

  final Quote quote;
  final VoidCallback? delete;

  QuoteCard({ required this.quote, required this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0) ,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Quote: ${quote.quote}', style: TextStyle(fontWeight: FontWeight.w600,
                fontSize: 16, color: Colors.black87)),
            Text('Author: ${quote.author}', style: TextStyle(fontWeight: FontWeight.w300,
            fontSize: 13)),
            IconButton( icon: Icon(Icons.delete),onPressed:delete)
          ],
        ),
      ),
    );
  }
}
