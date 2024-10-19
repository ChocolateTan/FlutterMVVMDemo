import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppStyle {
  static Color get primaryColor => Colors.white70;
  static Color get accentColor => Colors.orangeAccent;
  static Color get bgColor => Colors.black;

  static const double textSmall = 14;
  static const double textMedium = 20;
  static const double textLarge = 26;

  // static AppBarTheme get appBarTheme => const AppBarTheme(
  //   systemOverlayStyle: SystemUiOverlayStyle(
  //     statusBarColor: primaryColor,
  //     statusBarIconBrightness: Brightness.dark,
  //     statusBarBrightness: Brightness.light,
  //   )
  //   // backgroundColor: primaryColor,
  //   // titleTextStyle: TextStyle(color: Colors.white70),
  //   // toolbarTextStyle: TextStyle(color: Colors.white70),
  // );
  static TextTheme get textTheme => const TextTheme(
    bodySmall: TextStyle(color: Colors.white70, fontSize: textSmall, fontWeight: FontWeight.normal, decoration: TextDecoration.none),
    bodyMedium: TextStyle(color: Colors.white70, fontSize: textMedium, fontWeight: FontWeight.normal, decoration: TextDecoration.none),
    bodyLarge: TextStyle(color: Colors.white70, fontSize: textLarge, fontWeight: FontWeight.normal, decoration: TextDecoration.none),
  );

  static TextSelectionThemeData get textSelectionThemeData => const TextSelectionThemeData(
    selectionHandleColor: Colors.white70
  );

  static InputDecorationTheme get inputDecorationTheme => const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.white70, fontSize: textMedium, fontWeight: FontWeight.normal, decoration: TextDecoration.none),
    iconColor: Colors.white70,
    focusColor: Colors.white70,
    activeIndicatorBorder: BorderSide(
      color: Colors.white70
    ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70, width: 0.5)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1)),
    prefixIconColor: Colors.white70,
    suffixIconColor: Colors.white70,
    hintStyle: TextStyle(color: Colors.white30, fontSize: textMedium, fontWeight: FontWeight.normal, decoration: TextDecoration.none),
    isCollapsed: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4)
  );

  static TextStyle get defaultTextStyle => const TextStyle(color: Colors.white70, fontSize: textSmall, fontWeight: FontWeight.normal, decoration: TextDecoration.none);
  static TextStyle get defaultTextTitleStyle => const TextStyle(color: Colors.white, fontSize: textSmall, fontWeight: FontWeight.bold, decoration: TextDecoration.none);
}