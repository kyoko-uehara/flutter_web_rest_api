

import 'dart:convert';

import 'package:flutter/material.dart';

import 'results.dart';
import 'package:http/http.dart' as http;

class Services {

  //特集マスタAPI
  static const String url = "http://webservice.recruit.co.jp/hotpepper/special/v1/?key=e70a489f0c432b68&special_category=SPG6&format=json";

  //リクルート WEBサービス https://webservice.recruit.co.jp/about.html
  //[APIキー]e70a489f0c432b68
  // ignore: missing_return
  static Future<List<Map<String, dynamic>>> getSpcialData() async {
    try {
      http.Response response = await http.get(url);
      if (200 == response.statusCode) {

  //      final Result result = resultFromJson(response.body);
  //      List<Special> specialList =  result.getSpecial();

        final jsonResponse = json.decode(response.body);

        Map<String, dynamic> _jsonData = jsonResponse['results'];

        List<Map<String, dynamic>> specialList = [];
        for (int i=0; i < _jsonData['special'].length; i++){

          specialList.add(_jsonData['special'][i]);
          print(_jsonData['special'][i]);

        }

        // print("-----jsondata:" + jsonResponse.toString());
        // print("--------------------");
        print(_jsonData['special'].length);


        return specialList;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
