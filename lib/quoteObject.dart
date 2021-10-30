import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'quoteObject.dart';


final String QouteDb = 'Quotes';
final String columnId = '_id';
final String columnQuote = 'quote';
final String columnAuthor = 'author';




class Quote {
  String quote = '';
  String author = '';
  late int id;


  Quote (String quote, String author){
    this.quote = quote;
    this.author = author;

  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnQuote: quote,
      columnAuthor: author,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
  Quote.fromMap(Map<dynamic, dynamic> map) {
    id = map[columnId];
    author = map[columnAuthor];
    quote = map[columnQuote] ;
  }

}

class QuoteProvider {
  static final QuoteProvider _instance = QuoteProvider._internal();
  late Database db;

  factory QuoteProvider() {
    return _instance;
  }

  QuoteProvider._internal() {
    initDatabase();
  }

   initDatabase() async {
    db = openDatabase(
      join(await getDatabasesPath(), '$QouteDb.db'),
      // When the database is first created, create a table to store data.
      onCreate: (db, version) {
        db.execute(
          '''
            create table $QouteDb ( 
              $columnId integer primary key autoincrement, 
              $columnQuote text not null,
              $columnAuthor author not null)
          ''',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    ) as Database;
  }


  Future<Quote> insert(Quote Quote) async {
    Quote.id = await db.insert(QouteDb, Quote.toMap());
    return Quote;
  }

  Future<Quote?> getQuote(int id) async {
    List<Map> maps = await db.query('$QouteDb');
    if (maps.length > 0) {
      return Quote.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(QouteDb, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Quote Quote) async {
    return await db.update(QouteDb, Quote.toMap(),
        where: '$columnId = ?', whereArgs: [Quote.id]);
  }

  Future close() async => db.close();
}