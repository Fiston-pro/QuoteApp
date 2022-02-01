import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'quoteObject.dart';


final String qouteDb = 'Quotes';
final String columnId = '_id';
final String columnQuote = 'quote';
final String columnAuthor = 'author';




class Quote {
  String quote = '';
  String author = '';
  late int? id;


  Quote (this.quote, this.author, [this.id]);

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
  late Database database;

  factory QuoteProvider() {
    return _instance;
  }

  QuoteProvider._internal() {
    initDatabase();
  }

   initDatabase() async {
    database = openDatabase(
      join(await getDatabasesPath(), '$qouteDb.db'),
      // When the database is first created, create a table to store data.
      onCreate: (db, version) {
        db.execute(
          '''
            create table $qouteDb ( 
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


  Future<Quote> insertQuote(Quote Quote) async {
    Database db = await database;
    Quote.id = await db.insert(qouteDb, Quote.toMap());
    return Quote;
  }

  Future<List<Quote>?> getQuote() async {
    Database db = await database;
    List<Map> maps = await db.rawQuery('SELECT * FROM Test');
    if (maps.length > 0) {
      return List.generate(maps.length, (i) {
        return Quote(maps[i]['quote'], maps[i]['author'], maps[i]['id']);
  });

    }
    return null;
  }
  // delete from database
  Future<int> deleteQuote(int id) async {
    Database db = await database;
    return await db.delete(qouteDb, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateQuote(Quote Quote) async {
    Database db = await database;
    return await db.update(qouteDb, Quote.toMap(),
        where: '$columnId = ?', whereArgs: [Quote.id]);
  }

  Future close() async => database.close();
}
