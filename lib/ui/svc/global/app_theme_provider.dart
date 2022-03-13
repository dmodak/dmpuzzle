import 'package:dmpuzzle/ui/svc/global/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel with ChangeNotifier {
  static const String CurrentThemeKey = 'ThemeKey';
  static const String CurrentThemeColorKey = 'ThemeColorKey';
  //
  static const String ThemeLightCd = 'LIGHT';
  static const String ThemeDarkCd = 'DARK';
  //
  static const String ThemeColorOrangeCd = 'ORANGE';
  static const String ThemeColorGreenCd = 'GREEN';
  static const String ThemeColorBlueCd = 'BLUE';
  //
  AppThemes _appThemes = AppThemes();
  //
  ThemeData _currentTheme = ThemeData();

  String _defaultThemeCd = ThemeLightCd;
  String _defaultThemeColorCd = ThemeColorOrangeCd;

  ThemeModel() {
    getThemPrefCd();
    getThemColorPrefCd();
    resetCurrentTheme();
    //  print('Init theme : ' + _defaultThemeCd);
  }

  getThemPrefCd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _defaultThemeCd =
        prefs.getString(ThemeModel.CurrentThemeKey) ?? ThemeLightCd;
  }

  getThemColorPrefCd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _defaultThemeColorCd =
        prefs.getString(ThemeModel.CurrentThemeColorKey) ?? ThemeColorOrangeCd;
  }

  resetThemePrefCd(String pThemeNm) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(ThemeModel.CurrentThemeKey, pThemeNm);
    _defaultThemeCd = pThemeNm;
    // print('Set theme : ' + _defaultThemeCd);

    resetCurrentTheme();

    notifyListeners();
  }

  resetThemeColorPrefCd(String pThemeColorNm) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(ThemeModel.CurrentThemeColorKey, pThemeColorNm);
    _defaultThemeColorCd = pThemeColorNm;

    resetCurrentTheme();

    notifyListeners();
  }

  ThemeData getCurrentTheme() {
    return _currentTheme;
  }

  resetCurrentTheme() {
    // print('Set theme   : ' + _defaultThemeCd);

    /**
    switch (_defaultThemeCd) {
      case ThemeDarkCd:
        _appThemes.setTextColor(Colors.white);
        _appThemes.setPrimaryColor(Colors.black);

        switch (_defaultThemeColorCd) {
          case ThemeColorBlueCd:
            _appThemes.setAppBarTextColor(Colors.blue);
            _appThemes.setAppBarIconColor(Colors.blue);
            break;
          case ThemeColorGreenCd:
            _appThemes.setAppBarTextColor(Colors.green);
            _appThemes.setAppBarIconColor(Colors.green);
            break;
          default:
            _appThemes.setAppBarTextColor(Colors.deepOrange);
            _appThemes.setAppBarIconColor(Colors.deepOrange);
        }
        //_currentTheme = _appThemes.getDarkTheme();
        _currentTheme = _appThemes.getAppTheme();
        break;
      default:
        _appThemes.setTextColor(Colors.black);
        _appThemes.setAppBarTextColor(Colors.black);
        _appThemes.setAppBarIconColor(Colors.black);
        switch (_defaultThemeColorCd) {
          case ThemeColorBlueCd:
            _appThemes.setPrimaryColor(Colors.blue);
            break;
          case ThemeColorGreenCd:
            _appThemes.setPrimaryColor(Colors.green);
            break;
          default:
            _appThemes.setPrimaryColor(Colors.deepOrange);
        }
      //  _currentTheme = _appThemes.getLightTheme();
        _currentTheme = _appThemes.getAppTheme();

    }
    **/

    switch (_defaultThemeCd) {
      case ThemeDarkCd:
        _appThemes.setThemeColor(Colors.black);
        _appThemes.setAppTextColor(Colors.white);
        _appThemes.setAppBarTextColor(Colors.white);
        _appThemes.setAppIconColor(Colors.white);

        switch (_defaultThemeColorCd) {
          case ThemeColorBlueCd:
            _appThemes.setPrimaryColor(Colors.blue);
            break;
          case ThemeColorGreenCd:
            _appThemes.setPrimaryColor(Colors.green);
            break;
          default:
            _appThemes.setPrimaryColor(Colors.deepOrange);
        }
        break;
      default:
        _appThemes.setThemeColor(Colors.white);
        _appThemes.setAppTextColor(Colors.black);
        _appThemes.setAppBarTextColor(Colors.black);
        _appThemes.setAppIconColor(Colors.black);
        switch (_defaultThemeColorCd) {
          case ThemeColorBlueCd:
            _appThemes.setPrimaryColor(Colors.blue);
            break;
          case ThemeColorGreenCd:
            _appThemes.setPrimaryColor(Colors.green);
            break;
          default:
            _appThemes.setPrimaryColor(Colors.deepOrange);
        }
      //  _currentTheme = _appThemes.getLightTheme();
      //_currentTheme = _appThemes.getAppTheme();
    }

    _currentTheme = _appThemes.getAppTheme();
  }

  resetCurrentThemeColorxx() {
    // print('Set theme color : ' + _defaultThemeColorCd);

    switch (_defaultThemeColorCd) {
      case ThemeColorBlueCd:
        _currentTheme.colorScheme.copyWith(
          primary: Colors.blue,
          primaryVariant: Colors.blue.shade900,
          secondary: Colors.deepPurple,
          secondaryVariant: Colors.deepPurple.shade900,
          onPrimary: Colors.blueAccent,
          onSecondary: Colors.blueAccent,
          onSurface: Colors.blue.shade900,
          onBackground: Colors.blue.shade900,
        );

        //_currentTheme.appBarTheme.copyWith(color: Colors.blue);
        break;
      case ThemeColorGreenCd:
        _currentTheme.colorScheme.copyWith(
          primary: Colors.green,
          primaryVariant: Colors.green.shade900,
          secondary: Colors.deepPurple,
          secondaryVariant: Colors.deepPurple.shade900,
          onPrimary: Colors.greenAccent,
          onSecondary: Colors.greenAccent,
          onSurface: Colors.green.shade900,
          onBackground: Colors.green.shade900,
        );
        // _currentTheme.appBarTheme.copyWith(color: Colors.green);

        break;
      default:
        _currentTheme.colorScheme.copyWith(
          primary: Colors.orange,
          primaryVariant: Colors.orange.shade900,
          secondary: Colors.deepPurple,
          secondaryVariant: Colors.deepPurple.shade900,
          onPrimary: Colors.orangeAccent,
          onSecondary: Colors.orangeAccent,
          onSurface: Colors.orange.shade900,
          onBackground: Colors.orange.shade900,
        );
      // _currentTheme.appBarTheme.copyWith(color: Colors.deepOrange);
    }
  }
}
