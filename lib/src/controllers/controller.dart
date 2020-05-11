import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kdresponse/src/models/ncdc_model.dart';
import 'package:kdresponse/src/models/route_argument.dart';
import 'package:kdresponse/src/repositories/info_repository.dart';
import 'package:kdresponse/src/repositories/user_repository.dart';

import 'package:mvc_pattern/mvc_pattern.dart';


class Controller extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  NcdcModel infos;

  bool loaded = false;
  Controller() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void setCurrentUser(Map<String, dynamic> userData) async{
    setUserData(json.encode(userData)); 
   
  }




void requestInfo() async {
   final Stream<NcdcModel> stream = await getInfo();
    stream.listen((NcdcModel _infos) {
      setState(() => infos = _infos);
   
    }, onError: (a) {
      print(a);
    }, onDone: () {
      getCurrentUser().then((val){
          
        if(val.state != null){
             Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Home',
          arguments: RouteArgument(
              param: infos,heroTag: val.state
             ));
        }else{
           Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Setup',
          arguments: RouteArgument(
              param: infos,
             ));
        }


          
      });
    });
}
}