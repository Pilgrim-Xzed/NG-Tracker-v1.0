import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:kdresponse/config/app_config.dart' as config;
import 'package:kdresponse/route_generator.dart';
import 'package:kdresponse/src/repositories/settings_repository.dart' as settingRepo;

void main() async {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness){
          if (brightness == Brightness.light) {
            return ThemeData(
              fontFamily: 'Poppins',
              primaryColor: Colors.white,
              brightness: brightness,
              accentColor: config.ColorsTheme().mainColor(1),
              focusColor: config.ColorsTheme().accentColor(1),
              hintColor: config.ColorsTheme().secondColor(1),
              textTheme: TextTheme(
                headline: TextStyle(fontSize: 20.0, color: config.ColorsTheme().secondColor(1)),
                display1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.ColorsTheme().secondColor(1)),
                display2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.ColorsTheme().secondColor(1)),
                display3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.ColorsTheme().mainColor(1)),
                display4: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.ColorsTheme().secondColor(1)),
                subhead: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.ColorsTheme().secondColor(1)),
                title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.ColorsTheme().mainColor(1)),
                body1: TextStyle(fontSize: 12.0, color: config.ColorsTheme().secondColor(1)),
                body2: TextStyle(fontSize: 14.0, color: config.ColorsTheme().secondColor(1)),
                caption: TextStyle(fontSize: 12.0, color: config.ColorsTheme().accentColor(1)),
              ),
            );
          } else {
            return ThemeData(
              fontFamily: 'Poppins',
              primaryColor: Color(0xFF252525),
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Color(0xFF2C2C2C),
              accentColor: config.ColorsTheme().mainDarkColor(1),
              hintColor: config.ColorsTheme().secondDarkColor(1),
              focusColor: config.ColorsTheme().accentDarkColor(1),
              textTheme: TextTheme(
                headline: TextStyle(fontSize: 20.0, color: config.ColorsTheme().secondDarkColor(1)),
                display1:
                    TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.ColorsTheme().secondDarkColor(1)),
                display2:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.ColorsTheme().secondDarkColor(1)),
                display3:
                    TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.ColorsTheme().mainDarkColor(1)),
                display4:
                    TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.ColorsTheme().secondDarkColor(1)),
                subhead:
                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.ColorsTheme().secondDarkColor(1)),
                title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.ColorsTheme().mainDarkColor(1)),
                body1: TextStyle(fontSize: 12.0, color: config.ColorsTheme().secondDarkColor(1)),
                body2: TextStyle(fontSize: 14.0, color: config.ColorsTheme().secondDarkColor(1)),
                caption: TextStyle(fontSize: 12.0, color: config.ColorsTheme().secondDarkColor(0.6)),
              ),
            );
          }
        
        },
        themedWidgetBuilder: (context, theme) {
          return ValueListenableBuilder(valueListenable: settingRepo.locale, builder: (context, Locale value,_){
            print(value);
            return MaterialApp(
              title:"KD Response",
              initialRoute: '/Splash',
              onGenerateRoute: RouteGenerator.generateRoute,
              debugShowCheckedModeBanner: false,
              theme: theme,
            );
          });
        });
  }
}
