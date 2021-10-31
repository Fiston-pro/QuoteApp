import 'package:firstapp/quoteCard.dart';
import 'package:flutter/material.dart';
import 'quoteObject.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {

  // Stuff for the database
  QuoteProvider dbService = QuoteProvider();

  // Stuff for the dialog
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingAuthor = TextEditingController();
  final TextEditingController _textEditingQuote = TextEditingController();


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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
                await showInformationDialog(context);
              },
        child: Icon(Icons.add,),
        backgroundColor: Colors.black,
      ),
      );

  }

  // function for the dialog
  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.black87,
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _textEditingAuthor,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Enter an author";
                        },
                        maxLength: 20,
                        decoration:
                            InputDecoration(
                              hintText: "Author",
                              hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,letterSpacing: 1),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20)
                          ),
                              ),
                            
                      ),
                      TextFormField(
                        controller: _textEditingQuote,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Enter a Quote";
                        },
                        maxLength: 500,
                        maxLines: 5,
                        cursorColor: Colors.black,
                        style: TextStyle(
                          color: Colors.white
                        ),
                        decoration: InputDecoration(
                          hintText: "Quote",
                          hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,letterSpacing: 1),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)
                          ),
                
                      ),)
                    ],
                  )),
              title: Text('New Quote', style: TextStyle(color: Colors.white),),
              actions: <Widget>[
                InkWell(
                  child: Text('OK   ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,letterSpacing: 1),),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

}




