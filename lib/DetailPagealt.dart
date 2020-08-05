import 'dart:async';
import 'dart:ffi';
import 'package:gdgbloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'http_service.dart';
import 'main.dart';
import 'picture.dart';

class DetailPage extends StatefulWidget {
  final Data data;
  final PicData strd;
  DetailPage({
    Key key,
    this.data,
    this.strd,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState(this.data, this.strd);
}

class _DetailPageState extends State<DetailPage> {
  String url = "";

  _DetailPageState(Data data, PicData strd);

  void post() async {
    var result = await http.post(
      url,
    );
    print(result.body);
    //s1 = result.body;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.arrow_forward_ios),
        label: Text("Submit"),
        onPressed: (){
          print(url);
          post();},
      ),
    );
  }
}
