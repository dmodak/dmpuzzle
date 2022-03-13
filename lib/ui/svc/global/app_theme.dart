import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppThemes {
  Color _themeColor = Colors.white;
  Color _appIconColor = Colors.black;
  Color _appTextColor = Colors.black;
  Color _primaryColor = Colors.deepOrange;
  Color _appBarTextColor = Colors.black;

  Color getThemeColor() {
    return _themeColor;
  }

  setThemeColor(Color pThemeColor) {
    _themeColor = pThemeColor;
  }

  Color getPrimaryColor() {
    return _primaryColor;
  }

  setPrimaryColor(Color pPrimaryColor) {
    _primaryColor = pPrimaryColor;
  }

  Color getAppTextColor() {
    return _appTextColor;
  }

  setAppTextColor(Color pAppTextColor) {
    _appTextColor = pAppTextColor;
  }

  Color getAppBarTextColor() {
    return _appBarTextColor;
  }

  setAppBarTextColor(Color pAppBarTextColor) {
    _appBarTextColor = pAppBarTextColor;
  }

  Color getAppIconColor() {
    return _appIconColor;
  }

  setAppIconColor(Color pAppIconColor) {
    _appIconColor = pAppIconColor;
  }

  AppThemes() {
    // darkTheme = getDarkTheme();
    // lightTheme = getLightTheme();
  }

  ThemeData getAppTheme() {
    return ThemeData(
      scaffoldBackgroundColor: getThemeColor(),
      primaryColor: getPrimaryColor(),
      // brightness: Brightness.light,
      //  primarySwatch: Colors.deepOrange,
      // backgroundColor: Colors.white,
      shadowColor: getPrimaryColor(),
      canvasColor: getThemeColor(),

      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'NotoSans',

      // AppBar Theme definition
      appBarTheme: AppBarTheme(
        color: getPrimaryColor(),
        elevation: 50.0,
        iconTheme: IconThemeData(
          color: getAppIconColor(),
        ),

        // AppBar Text Theme definition
        // light -> .w300, regular -> .w400, medium -> .w500
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 96.0,
              fontWeight: FontWeight.w300,
              color: getAppBarTextColor()),
          headline2: TextStyle(
              fontSize: 60.0,
              fontWeight: FontWeight.w300,
              color: getAppBarTextColor()),
          headline3: TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.w400,
              color: getAppBarTextColor()),
          headline4: TextStyle(
              fontSize: 34.0,
              fontWeight: FontWeight.w400,
              color: getAppBarTextColor()),
          headline5: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w400,
              color: getAppBarTextColor()),
          headline6: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: getAppBarTextColor()),
          subtitle1: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: getAppBarTextColor()),
          subtitle2: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: getAppBarTextColor()),
          bodyText1: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: getAppBarTextColor()),
          bodyText2: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: getAppBarTextColor()),
          button: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: getAppBarTextColor()),
          caption: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: getAppBarTextColor()),
          overline: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w400,
              color: getAppBarTextColor()),
        ),
      ),

      //
      bottomAppBarTheme: BottomAppBarTheme(
        color: getPrimaryColor(),
        elevation: 10.0,
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 10.0,
        selectedItemColor: getPrimaryColor(),
      ),

      buttonBarTheme: ButtonBarThemeData(
        buttonAlignedDropdown: false,
        overflowDirection: VerticalDirection.down,
      ),

      colorScheme: ColorScheme(
          primary: getPrimaryColor(),
          primaryVariant: Colors.deepOrange.shade900,
          secondary: Colors.deepPurple,
          secondaryVariant: Colors.deepPurple.shade900,
          surface: Colors.white,
          background: Colors.white,
          error: Colors.red,
          onPrimary: Colors.deepOrange.shade900,
          onSecondary: Colors.deepPurple.shade900,
          onSurface: Colors.deepOrange.shade900,
          onBackground: Colors.deepOrange.shade900,
          onError: Colors.red,
          brightness: Brightness.light),

      iconTheme: IconThemeData(
        color: getAppIconColor(),
      ),

      // Card Theme definition
      cardTheme: CardTheme(
        color: getThemeColor(),
        shadowColor: getPrimaryColor(),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: getPrimaryColor(), width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 20.0,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(getPrimaryColor()),
          foregroundColor: MaterialStateProperty.all<Color>(getAppTextColor()),
          shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
          overlayColor: MaterialStateProperty.all<Color>(Colors.grey),
          elevation: MaterialStateProperty.all<double>(15),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          )),
          textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: getAppBarTextColor())),
          padding:
              MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(5)),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(getPrimaryColor()),
          foregroundColor: MaterialStateProperty.all<Color>(getAppTextColor()),
          shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
          overlayColor: MaterialStateProperty.all<Color>(Colors.grey),
          elevation: MaterialStateProperty.all(15.0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          )),
          textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: getAppBarTextColor())),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(getPrimaryColor()),
          foregroundColor: MaterialStateProperty.all<Color>(getAppTextColor()),
          shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
          overlayColor: MaterialStateProperty.all<Color>(Colors.grey),
          elevation: MaterialStateProperty.all(15.0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          )),
          textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: getAppBarTextColor())),
        ),
      ),

      // Text Theme definition
      // light -> .w300, regular -> .w400, medium -> .w500
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 96.0,
            fontWeight: FontWeight.w300,
            color: getAppTextColor()),
        headline2: TextStyle(
            fontSize: 60.0,
            fontWeight: FontWeight.w300,
            color: getAppTextColor()),
        headline3: TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.w400,
            color: getAppTextColor()),
        headline4: TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.w400,
            color: getAppTextColor()),
        headline5: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w400,
            color: getAppTextColor()),
        headline6: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: getAppTextColor()),
        subtitle1: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: getAppTextColor()),
        subtitle2: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: getAppTextColor()),
        bodyText1: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: getAppTextColor()),
        bodyText2: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: getAppTextColor()),
        button: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: getAppTextColor()),
        caption: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: getAppTextColor()),
        overline: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w400,
            color: getAppTextColor()),
      ),
    );
  }
}

class BoxTheme {
  BuildContext? context;

  BoxTheme(BuildContext pContext) {
    this.context = pContext;
  }
  //
  BoxDecoration getWindowBoxDecor() {
    return BoxDecoration(
      border: Border.all(color: Colors.black, width: 1),
      color: Colors.white60,
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.8), spreadRadius: 3),
      ],
    );
  }

  BoxDecoration getWinTitleBoxDecor() {
    return BoxDecoration(
      border: Border.all(color: Colors.black, width: 1),
      color: Colors.white60,
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.8), spreadRadius: 3),
      ],
    );
  }

  BoxDecoration getTabBarBoxDecor() {
    return BoxDecoration(
      border: Border.all(color: Colors.black),
      color: Theme.of(context!).primaryColor,
    );
  }

  BoxDecoration getMainDtlBoxDecor() {
    return BoxDecoration(
      border: Border.all(color: Colors.black, width: 1),
      color: Colors.white60,
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.8), spreadRadius: 3),
      ],
    );
  }

  BoxDecoration getDtlRecBoxDecor() {
    return BoxDecoration(
      color: Colors.white60,
      border: Border.all(
        color: Colors.black,
        width: 1,
      ),
    );
  }

  BoxDecoration getTblGridBoxDecor() {
    return BoxDecoration(
      color: Colors.white60,
      border: Border.all(
        color: Colors.black,
        width: 1,
      ),
    );
  }

  static InputDecoration getDtlInputDecoration(
      BuildContext context, String lblNm) {
    return InputDecoration(
      labelStyle: Theme.of(context).textTheme.subtitle1,
      border: OutlineInputBorder(),
      labelText: lblNm,
    );
  }
}
