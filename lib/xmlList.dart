import 'dart:async';
import 'dart:convert';



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:flutter_web/special.dart';



// ignore: camel_case_types
class xmlListPage extends StatefulWidget {
  xmlListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _xmlListPageState createState() => _xmlListPageState();
}

// ignore: camel_case_types
class _xmlListPageState extends State<xmlListPage> {

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



  //Jsonをlistにする
  Future<List<Special>> getSpecialFormJson(BuildContext context)async{
    String jsonString  = await DefaultAssetBundle.of(context).loadString("lib/apiResponse.json");
    List<dynamic> raw = jsonDecode(jsonString);
    return raw.map((f) => Special.fromJson(f)).toList();
  }


  //xmlをlistにする
  Future<List<Special>> getSpecialFormXML(BuildContext context)async{
    String xmlString  = await DefaultAssetBundle.of(context).loadString("lib/apiResponse.xml");
    var raw = xml.XmlDocument.parse(xmlString);
    var elements = raw.findAllElements("special");

    return elements.map((element){
      return Special(element.findElements("code").first.text,
          element.findElements("name").first.text);
    }).toList();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: getSpecialFormJson(context),
          builder: (context, data){
            if(data.hasData){
              List<Special> special = data.data;

              return ListView.builder(
                  itemCount: special.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      title:Text(
                        special[index].code,
                        style: TextStyle(fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(special[index].name),
                    );
                  });
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          },

        ),
      ),
    );
  }
}
