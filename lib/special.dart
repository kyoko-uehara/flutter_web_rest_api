import 'package:flutter/material.dart';
import 'package:xml/xml.dart';
class Special{

  String _code,_name,_specialCategory;

  Special(this._code,this._name,this._specialCategory);

  factory Special.fromJson(Map<String,dynamic> json){
    if(json == null){
      return null;
    }else{
      return Special(json["code"], json["name"], json["specialCategory"]);
    }
  }
  get code => this._code;
  get name => this._name;
  get specialCategory => this._specialCategory;

}