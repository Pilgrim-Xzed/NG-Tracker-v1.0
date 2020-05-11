
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kdresponse/config/app_config.dart';
import 'package:kdresponse/src/controllers/setup_controller.dart';
import 'package:kdresponse/src/models/route_argument.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

List<String> states = [
  "Lagos",
  "Kano",
  "FCT",
  "Gombe",
  "Borno",
  "Ogun",
  "Bauchi",
  "Edo",
  "Sokoto",
  "Katsina",
  "Kaduna",
  "Osun",
  "Oyo",
  "Delta",
  "Akwa Ibom",
  "Kwara",
  "Rivers",
  "Ondo",
  "Ekiti",
  "Zamfara",
  "Taraba",
  "Jigawa",
  "Nasarawa",
  "Bayelsa",
  "Yobe",
  "Enugu",
  "Adamawa",
  "Niger",
  "Ebonyi",
  "Imo",
  "Abia",
  "Kebbi",
  "Anambra",
  "Plateau",
  "Benue"
];

class SetupScreen extends StatefulWidget {
  RouteArgument routeArgument;
  SetupScreen({Key key, this.routeArgument}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return SetupScreenState();
  }
}

class SetupScreenState extends StateMVC<SetupScreen>
    {
  SetupController _con;
  String selectedState = "Select State of Residence";
  SetupScreenState() : super(SetupController()) {
    _con = controller;
  }

  @override
  void initState() {
    states.sort();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _con.scaffoldKey,
      body: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          Positioned(
            right: 0,
            top: 0,
            height: SizeConfig.blockSizeVertical * 50,
            width: SizeConfig.blockSizeHorizontal * 100,
            child: WavyHeader(),
          ),
          Positioned(
            right: 0,
            top: SizeConfig.blockSizeVertical * 8,
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
            top: SizeConfig.blockSizeVertical * 53,
            height: SizeConfig.blockSizeVertical * 18,
            width: SizeConfig.blockSizeHorizontal * 70,
            child: Container(
                width: SizeConfig.blockSizeVertical * 40,
                child: Column(children: <Widget>[
                  Text("NG-COVID-19 Tracker",
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 5,
                        color: Colors.grey,
                        fontFamily: "Fredoka",
                      )),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  Center(
                    child: Text(
                      "NOTE: All data and statistics are from covid19.ncdc.gov.ng/reports ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ])),
          ),
          Positioned(
            left: SizeConfig.blockSizeHorizontal * 13,
            top: SizeConfig.blockSizeVertical * 75,
            height: SizeConfig.blockSizeVertical * 6,
            width: SizeConfig.blockSizeHorizontal * 75,
            child: GestureDetector(
              onTap: (){
                showStateDialog(context);
              },
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(5)),
                  width: SizeConfig.blockSizeVertical * 40,
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Center(
                              child: Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            color: Colors.green,
                          )),
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      width: 1.0, color: Colors.grey))),
                          height: SizeConfig.blockSizeVertical * 4,
                          width: SizeConfig.blockSizeHorizontal * 10,
                        ),
                        Container(
                          
                          child: Text(
                            "  $selectedState",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                color: Colors.black54),textAlign: TextAlign.left,
                          ),
                          
                          width: SizeConfig.blockSizeHorizontal * 60,
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          Positioned(
              left: SizeConfig.blockSizeHorizontal * 13,
              top: SizeConfig.blockSizeVertical * 83,
              height: SizeConfig.blockSizeVertical * 6,
              child: RaisedButton(
                onPressed: (){
                  _con.setCurrentUser({"state":selectedState},widget.routeArgument.param);
                },
                padding: EdgeInsets.all(0.0),
                textColor: Colors.white,
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 75,
                  color: Colors.green,
                  child: Center(
                      child: Row(children: <Widget>[
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 10,
                    ),
                    Text('Get Started',
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 4.0)),
                    Spacer(),
                    Icon(FontAwesomeIcons.arrowCircleRight),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 10,
                    ),
                  ])),
                ),
              )),
        ],
      ),
    );
  }

  void showStateDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              
              content: Container(
                  
                  width: SizeConfig.blockSizeHorizontal * 70,
                  height: SizeConfig.blockSizeVertical * 40,
                  child: ListView(
                    children: states.map((f)=>InkWell(
                      onTap: (){
                        setState(()=>
                        selectedState = f
                        );
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal:SizeConfig.blockSizeHorizontal*3),
                        child: Container(
                          padding: EdgeInsets.only(top:3),
                          height:SizeConfig.blockSizeVertical*4,
                          decoration: BoxDecoration(
                            border:Border(
                                    bottom: BorderSide(
                                        width: 0.3, color: Colors.grey))
                          ),
                          child: Text(f,style: TextStyle(color:Colors.grey),textAlign: TextAlign.center,),
                        ),
                      ),
                    )).toList()
                    ,
                  
                    )));
        });
  }
}

const List<Color> orangeGradients = [
  Color(0xFF56ab2f),
  Color(0xFFa8e063),
];

class WavyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopWaveClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: orangeGradients,
              begin: Alignment.topLeft,
              end: Alignment.center),
        ),
        height: MediaQuery.of(context).size.height / 2.5,
      ),
    );
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // This is where we decide what part of our image is going to be visible.
    var path = Path();
    path.lineTo(0.0, size.height);

    var firstControlPoint = new Offset(size.width / 7, size.height - 30);
    var firstEndPoint = new Offset(size.width / 6, size.height / 1.5);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width / 5, size.height / 4);
    var secondEndPoint = Offset(size.width / 1.5, size.height / 5);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint =
        Offset(size.width - (size.width / 9), size.height / 6);
    var thirdEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    ///move from bottom right to top
    path.lineTo(size.width, 0.0);

    ///finally close the path by reaching start point from top right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
