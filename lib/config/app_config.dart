import 'package:flutter/material.dart';


class SizeConfig {
 static MediaQueryData _mediaQueryData;
 static double screenWidth;
 static double screenHeight;
 static double blockSizeHorizontal;
 static double blockSizeVertical;
  
 static double _safeAreaHorizontal;
 static double _safeAreaVertical;
 static double safeBlockHorizontal;
 static double safeBlockVertical;

 
 void init(BuildContext context) {
  _mediaQueryData = MediaQuery.of(context);
  screenWidth = _mediaQueryData.size.width;
  screenHeight = _mediaQueryData.size.height;
  blockSizeHorizontal = screenWidth / 100;
  blockSizeVertical = screenHeight / 100;
   
 _safeAreaHorizontal = _mediaQueryData.padding.left + 
 _mediaQueryData.padding.right;
 _safeAreaVertical = _mediaQueryData.padding.top +
 _mediaQueryData.padding.bottom;
 safeBlockHorizontal = (screenWidth -
 _safeAreaHorizontal) / 100;
 safeBlockVertical = (screenHeight -
 _safeAreaVertical) / 100;
 }
}

class ColorsTheme {
//  Color _mainColor = Color(0xFFFF4E6A);
  Color _mainColor = Color(0xFFe1e1e1);
  Color _mainDarkColor = Color(0xFFea5c44);
  Color _secondColor = Color(0xFF228B22);
  Color _secondDarkColor = Color(0xFFccccdd);
  Color _accentColor = Color(0xFF0001FC);
  Color _accentDarkColor = Color(0xFF9999aa);
  Color _scaffoldColor = Color(0xFFFAFAFA);

  Color mainColor(double opacity) {
    return this._mainColor.withOpacity(opacity);
  }

  Color secondColor(double opacity) {
    return this._secondColor.withOpacity(opacity);
  }

  Color accentColor(double opacity) {
    return this._accentColor.withOpacity(opacity);
  }

  Color mainDarkColor(double opacity) {
    return this._mainDarkColor.withOpacity(opacity);
  }

  Color secondDarkColor(double opacity) {
    return this._secondDarkColor.withOpacity(opacity);
  }

  Color accentDarkColor(double opacity) {
    return this._accentDarkColor.withOpacity(opacity);
  }

  Color scaffoldColor(double opacity) {
    return _scaffoldColor.withOpacity(opacity);
  }
}