
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kdresponse/config/app_config.dart';
import 'package:kdresponse/src/controllers/controller.dart';

import 'package:mvc_pattern/mvc_pattern.dart';


class SplashScreen extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends StateMVC<SplashScreen>
    {
  Controller _con;
 
  SplashScreenState() : super(Controller()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.requestInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _con.scaffoldKey,
      backgroundColor:Colors.white,
      body: Stack(
        
        alignment: Alignment.centerRight,
        children: <Widget>[
        
          Positioned(
            right: 0,
            top: SizeConfig.blockSizeVertical * 7,
            height: SizeConfig.blockSizeVertical * 50,
            width: SizeConfig.blockSizeHorizontal * 100,
            child: Container(
              color: Colors.transparent,
              child: Center(
                  child: Image.asset("assets/images/covid19.png",
                      scale: SizeConfig.blockSizeVertical * 0.30,
                      color: Colors.green)),
            ),
          ),
          Positioned(
            left: SizeConfig.blockSizeHorizontal * 15,
            top: SizeConfig.blockSizeVertical * 50,
            height: SizeConfig.blockSizeVertical * 18,
            width: SizeConfig.blockSizeHorizontal * 70,
            child: Container(
                width: SizeConfig.blockSizeVertical * 40,
                child: Column(children: <Widget>[
                  RichText(text: TextSpan(text: "NG ", 
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 8,
                        color: Colors.green,fontWeight: FontWeight.bold,
                        fontFamily: "Aquatico",
                  ),children: [
                    TextSpan(text: "COVID-19", style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 5,
                        color: Colors.grey,
                        fontFamily: "Aquatico",
                  ))
                  ])),
                   SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  Center(
                    child: Text(
                      "Get present day information and visuals on the COVID 19 Pandemic in Nigeria as well as your state of residence ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                ])),
          ),

          Positioned(
            right: 0,
            top: SizeConfig.blockSizeVertical * 67,
            height: SizeConfig.blockSizeVertical * 20,
            width: SizeConfig.blockSizeHorizontal * 100,
            child: Container(
              color: Colors.transparent,
              child: Center(
                  child: Image.asset("assets/images/loader.gif",
                      scale: SizeConfig.blockSizeVertical * 0.45,
                      color: Colors.green)),
            ),
          ),
       
        ],
      ),
    );
  }
    }