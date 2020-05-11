import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kdresponse/src/models/ncdc_model.dart';
import 'package:kdresponse/src/models/route_argument.dart';
import 'package:kdresponse/src/repositories/info_repository.dart';
import 'package:kdresponse/src/repositories/user_repository.dart';

import 'package:mvc_pattern/mvc_pattern.dart';


class SetupController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  NcdcModel infos;

  bool loaded = false;
  SetupController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void setCurrentUser(Map<String, dynamic> userData, NcdcModel infos) async{
    setUserData(json.encode(userData)); 
   Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Home',
          arguments: RouteArgument(
              param: infos,heroTag: userData['state']
             ));
  }





}