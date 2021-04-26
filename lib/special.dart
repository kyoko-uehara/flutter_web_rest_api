import 'package:flutter/material.dart';
class Special{

  // ignore: non_constant_identifier_names
  String _code,_name;

  Special(this._code,this._name);

  factory Special.fromJson(Map<String,dynamic> json){
    if(json == null){
      return null;
    }else{
      return Special(json["code"], json["name"]);
    }
  }
  get code => this._code;
  get name => this._name;


}