import 'dart:async';



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:flutter_web/special.dart';

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

  List data;

  //リクルート WEBサービス https://webservice.recruit.co.jp/about.html
  //[APIキー]e70a489f0c432b68
  Future<String> getData() async{
    //特集マスタAPI
     var response = await http.get(
      "http://webservice.recruit.co.jp/hotpepper/special/v1/?key=e70a489f0c432b68&special_category=SPG6"
    );

     print('Response status: ${response.statusCode}');
     print('Response body: ${response.body}');

     return response.body;
     //return "特集マスタ";

  }

  var  xmlResponse = http.get("http://webservice.recruit.co.jp/hotpepper/special/v1/?key=e70a489f0c432b68&special_category=SPG6");



  //TODO xmlをlistにする
  Future<List<Special>> getSpecialFormXML(BuildContext context)async{
    String xmlString  = await DefaultAssetBundle.of(context).loadString("lib/apiResponse.xml");
    var raw = xml.XmlDocument.parse(xmlString);
    var elements = raw.findAllElements("special");

    return elements.map((element){
      return Special(element.findElements("code").first.text,
          element.findElements("name").first.text,
          element.findElements("_specialCategory").first.text);
    }).toList();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: getData,
          child: Text("Get Data"),
        ),
      ),
    );
  }
}
