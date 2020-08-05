import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class HTTPs extends StatefulWidget {
  @override
  _HTTPsState createState() => _HTTPsState();
}



class _HTTPsState extends State<HTTPs> {
  String url = 'https://api.myjson.com/bins/hqcke';
  void post() async {
var result = await http.post(
    "https://api.myjson.com/post/akshat@gmail.com/hqcke",
);
print(result);
}

  Future<String> makeRequest() async{
    var response = await http.get(Uri.encodeFull(url),headers: {"Accept":"application/json"});
    print(response.body);
    //List data;
    //var extractdata = jsonDecode(response.body);
    //data = extractdata;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.indigo),
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Column(
            children : <Widget> [ 
            RaisedButton(
          shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
),
          onPressed: () {
            makeRequest();
          },
          //color: Color.fromRGBO(58, 66, 86, 1.0),
          color: Colors.indigo,
          child:
              Text("Get Result", style: TextStyle(color: Colors.white)),
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
),
          onPressed: () {
            post();
          },
          //color: Color.fromRGBO(58, 66, 86, 1.0),
          color: Colors.indigo,
          child:
              Text("Post Request", style: TextStyle(color: Colors.white)),
        ),
          ]
        ),
      ),
      )
    );
  }
}