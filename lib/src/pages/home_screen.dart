import 'dart:convert';

import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kdresponse/config/app_config.dart';
import 'package:kdresponse/src/helpers/caller.dart';
import 'package:kdresponse/src/models/ncdc_model.dart';
import 'package:kdresponse/src/models/route_argument.dart';
import 'package:kdresponse/src/repositories/user_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import "dart:math";
import 'package:quiver/async.dart';

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

class HomeScreen extends StatefulWidget {
  RouteArgument routeArgument;

  HomeScreen({Key key, this.routeArgument}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final fromDate = DateTime(2020, 04, 26);
  final toDate = DateTime.now().subtract(Duration(days: 0));
  String selectedState = "Select State of Residence";
  List<Hotline> stateHotline;
  List<DataPoint> confirmedArray = [];
  List<DataPoint> deathArray = [];
  List<DataPoint> dischargedArray = [];
  List itemListing;
  var stateData;
  @override
  void initState() {
    for (var i = 0; i < widget.routeArgument.param.stats.length; i++) {
      confirmedArray.add(DataPoint<DateTime>(
          value:
              double.parse(widget.routeArgument.param.stats[i].confirmedCases),
          xAxis: DateTime.now().subtract(Duration(days: i))));
      deathArray.add(DataPoint<DateTime>(
          value: double.parse(widget.routeArgument.param.stats[i].discharged),
          xAxis: DateTime.now().subtract(Duration(days: i))));
      dischargedArray.add(DataPoint<DateTime>(
          value: double.parse(widget.routeArgument.param.stats[i].death),
          xAxis: DateTime.now().subtract(Duration(days: i))));
    }
    states.sort();

    setState(() {
      itemListing = [
        {
          "name": "Confirmed",
          "icon": "assets/images/confirmed.png",
          "count": "${widget.routeArgument.param.nationalInfo.confirmedCases}"
        },
        {
          "name": "Active Cases",
          "icon": "assets/images/active.png",
          "count": "${widget.routeArgument.param.nationalInfo.activeCases}"
        },
        {
          "name": "Discharged",
          "icon": "assets/images/discharged.png",
          "count": "${widget.routeArgument.param.nationalInfo.discharged}"
        },
        {
          "name": "Samples tested",
          "icon": "assets/images/tested.png",
          "count":
              "${widget.routeArgument.param.nationalInfo.totalSamplesTested}"
        },
        {
          "name": "Total Deaths",
          "icon": "assets/images/dead.png",
          "count": "${widget.routeArgument.param.nationalInfo.deaths}"
        },
      ];

      stateData = widget.routeArgument.param.stateData
          .where((f) => f.stateName == widget.routeArgument.heroTag.toString())
          .toList();

      stateHotline = widget.routeArgument.param.hotline
          .where((f) => f.state == widget.routeArgument.heroTag.toString())
          .toList();
    });
    super.initState();
  }

  updateState(String sState) {
    setUserData(json.encode({"state": sState}));
    setState(() {
      stateData = widget.routeArgument.param.stateData
          .where((f) => f.stateName == sState)
          .toList();

          stateHotline = widget.routeArgument.param.hotline
          .where((f) => f.state == sState)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF006400).withOpacity(0.9),
        elevation: 0,
        title: Text("Nation Wide Stats",
            style: Theme.of(context).textTheme.display1.merge(TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.blockSizeHorizontal * 3))),
        actions: <Widget>[
          Row(children: <Widget>[
            Text(Jiffy().yMMMMd.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.blockSizeHorizontal * 3.4)),
            SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
            Icon(
              FontAwesomeIcons.calendar,
              color: Colors.white,
              size: SizeConfig.blockSizeHorizontal * 4,
            ),
            SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
          ])
        ],
      ),
      body: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          Positioned(
            right: 0,
            top: 0,
            height: SizeConfig.blockSizeVertical * 25,
            width: SizeConfig.blockSizeHorizontal * 100,
            child: Container(
                padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                color: Color(0xFF006400),
                child: ListView.builder(
                  itemCount: itemListing.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    double _marginLeft = 0;
                    (index == 0)
                        ? _marginLeft = SizeConfig.blockSizeHorizontal * 50
                        : _marginLeft = 0;
                    return InkWell(
                      splashColor:
                          Theme.of(context).accentColor.withOpacity(0.08),
                      highlightColor: Colors.transparent,
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 1,
                                right: SizeConfig.blockSizeHorizontal),
                            width: SizeConfig.blockSizeHorizontal * 24,
                            height: SizeConfig.blockSizeVertical * 12,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: Theme.of(context).accentColor),
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: SizeConfig.blockSizeVertical),
                                Container(
                                  padding: EdgeInsets.only(bottom: 0.0),
                                  child: Image.asset(
                                    itemListing[index]['icon'],
                                    scale: SizeConfig.blockSizeVertical * 0.25,
                                  ),
                                ),
                                Text(
                                  itemListing[index]['name'],
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 1.5),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  itemListing[index]['count'],
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 1.5,
                                      fontFamily: 'Aquatico',
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )),
          ),
          Positioned(
              right: SizeConfig.blockSizeHorizontal * 5,
              top: SizeConfig.blockSizeVertical * 16,
              height: SizeConfig.blockSizeVertical * 30,
              width: SizeConfig.blockSizeHorizontal * 90,
              child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  elevation: 1.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 1.5,
                        horizontal: SizeConfig.blockSizeHorizontal * 5),
                    child: BezierChart(
                      fromDate: fromDate,
                      bezierChartScale: BezierChartScale.WEEKLY,
                      toDate: toDate,
                      selectedDate: toDate,
                      series: [
                        BezierLine(
                            label: "Confirmed Cases",
                            lineColor: Colors.green,
                            data: confirmedArray),
                        BezierLine(
                            lineColor: Colors.grey,
                            lineStrokeWidth: 2.0,
                            label: "Discharged",
                            data: deathArray),
                        BezierLine(
                            lineColor: Colors.redAccent,
                            lineStrokeWidth: 2.0,
                            label: "Deaths",
                            data: dischargedArray),
                      ],
                      config: BezierChartConfig(
                          verticalIndicatorStrokeWidth: 3.6,
                          verticalIndicatorColor: Colors.black12,
                          showVerticalIndicator: true,
                          contentWidth: SizeConfig.blockSizeVertical * 2,
                          backgroundColor: Colors.white,
                          xAxisTextStyle: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.blockSizeVertical * 1.0)),
                    ),
                  ))),
          Positioned(
              right: SizeConfig.blockSizeHorizontal * 5,
              top: SizeConfig.blockSizeVertical * 47,
              height: SizeConfig.blockSizeVertical * 16,
              width: SizeConfig.blockSizeHorizontal * 90,
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 0.0,
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image.asset("assets/images/niger.png",
                              scale: SizeConfig.blockSizeVertical * 3),
                          Column(children: <Widget>[
                            Text("${stateData[0].stateName}",
                                style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical * 3.0,
                                )),
                            Text(
                              "Confirmed Cases : ${stateData[0].totalCases}",
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical * 1.5,
                                  color: Colors.black87),
                            ),
                            OutlineButton(
                                child: Text(
                                  "Change State",
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 3),
                                ),
                                borderSide: BorderSide(color: Colors.green),
                                onPressed: () {
                                  showStateDialog(context);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        SizeConfig.blockSizeHorizontal * 3))),
                          ])
                        ])),
              )),
          Positioned(
              right: SizeConfig.blockSizeHorizontal * 5,
              top: SizeConfig.blockSizeVertical * 64,
              height: SizeConfig.blockSizeVertical * 13,
              width: SizeConfig.blockSizeHorizontal * 90,
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 1.0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    width: 0.5, color: Colors.grey))),
                        height: SizeConfig.blockSizeVertical * 12,
                        width: SizeConfig.blockSizeHorizontal * 28,
                        child: Center(
                            child: Column(children: <Widget>[
                          Image.asset(
                            "assets/images/active.png",
                            scale: SizeConfig.blockSizeVertical * 0.25,
                            color: Colors.green,
                          ),
                          Text(
                            "Active Cases",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 1.5),
                          ),
                          Text(
                            "${stateData[0].activeCases}",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 1.5,
                                fontFamily: 'Aquatico',
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    width: 0.5, color: Colors.grey))),
                        height: SizeConfig.blockSizeVertical * 12,
                        width: SizeConfig.blockSizeHorizontal * 28,
                        child: Center(
                            child: Column(children: <Widget>[
                          Image.asset(
                            "assets/images/discharged.png",
                            scale: SizeConfig.blockSizeVertical * 0.25,
                            color: Colors.grey,
                          ),
                          Text(
                            "Discharged",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 1.5,
                                color: Colors.grey),
                          ),
                          Text(
                            "${stateData[0].totalDischarged}",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 1.5,
                                fontFamily: 'Aquatico',
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                      ),
                      Container(
                        height: SizeConfig.blockSizeVertical * 12,
                        width: SizeConfig.blockSizeHorizontal * 28,
                        child: Center(
                            child: Column(children: <Widget>[
                          Image.asset(
                            "assets/images/dead.png",
                            scale: SizeConfig.blockSizeVertical * 0.25,
                            color: Colors.red,
                          ),
                          Text(
                            "Total Deaths",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 1.5,
                                color: Colors.red),
                          ),
                          Text(
                            "${stateData[0].totalDeaths}",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 1.5,
                                fontFamily: 'Aquatico',
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                      ),
                    ]),
              )),
          Positioned(
              right: SizeConfig.blockSizeHorizontal * 5,
              top: SizeConfig.blockSizeVertical * 80,
              height: SizeConfig.blockSizeVertical * 5,
              width: SizeConfig.blockSizeHorizontal * 90,
              child: Container(
                child: OutlineButton(
                    splashColor: Colors.white,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 10),
                        CircleAvatar(
                          child: Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: SizeConfig.blockSizeHorizontal * 4,
                          ),
                          backgroundColor: Color(0xFF006400),
                          radius: SizeConfig.blockSizeHorizontal * 3,
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 10),
                        Text(
                          "${stateData[0].stateName} State Hotline",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 4,
                              color: Colors.green),
                        ),
                      ],
                    ),
                    borderSide: BorderSide(color: Colors.green),
                    onPressed: () {
                      showHotlineDialog(context);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            SizeConfig.blockSizeHorizontal * 3))),
              )),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

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
                    children: states
                        .map((f) => InkWell(
                              onTap: () {
                                updateState(f);
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.blockSizeHorizontal * 3),
                                child: Container(
                                  padding: EdgeInsets.only(top: 3),
                                  height: SizeConfig.blockSizeVertical * 4,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 0.3, color: Colors.grey))),
                                  child: Text(
                                    f,
                                    style: TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  )));
        });
  }

  void showHotlineDialog(BuildContext context) async {
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
                    children: stateHotline[0].numbers
                        .map((f) => InkWell(
                              onTap: () {
                              URL.launchURL("tel:$f");
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(
                                  0),
                                child: Material(
                                  elevation: 0,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top:
                                            SizeConfig.blockSizeHorizontal * 5),
                                    height: SizeConfig.blockSizeVertical * 8,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 0.3,
                                                color: Colors.grey))),
                                    child: Row(
                                      
                                      children: <Widget>[
                                          SizedBox(width: SizeConfig.blockSizeHorizontal * 10),
                                      CircleAvatar(child: Icon(FontAwesomeIcons.phoneAlt,size: SizeConfig.blockSizeHorizontal*4,color: Colors.white,),radius:SizeConfig.blockSizeHorizontal*5 ,backgroundColor: Colors.green,),
                                        SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
                                      Text(
                                        f,
                                        style: TextStyle(color: Colors.grey,fontSize: SizeConfig.blockSizeHorizontal*4),
                                        textAlign: TextAlign.center,
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  )));
        });
  }
}
