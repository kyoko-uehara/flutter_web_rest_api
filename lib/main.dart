import 'dart:async';
import 'dart:convert';
import 'dart:developer';




import 'package:flutter/material.dart';
import 'results.dart';
import 'services.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(MaterialApp(
    home: MyHomePage(title: 'HTTP Requests and REST API'),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Map<String, dynamic>>  _spcial;
  bool _loading;


  @override
  void initState() {
    super.initState();
    _loading = true;
    Services.getSpcialData().then((data) {
      setState(() {
        _spcial = data;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body:Container(
          color: Colors.white,
          child: ListView.builder(
              itemCount: null==_spcial ? 0 : _spcial.length,
              itemBuilder: (context, index){
                Map<String, dynamic> special = _spcial[index];
                return ListTile(
                  title: Text(special['code']),
                  subtitle: Text(special['name']),

                );
              }),

        )


    );
  }
}

