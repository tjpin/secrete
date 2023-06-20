import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

//primary dark - #262424

// Light Colors *******
// ********************
HexColor mainBlack = HexColor("#262424");
HexColor darkBlack = HexColor("#191717");
HexColor selectedColor = HexColor("#eff0f0");
Color mainWhite = Colors.white;
Color mainOrange = Colors.deepOrange;

ThemeData lightTheme() => ThemeData(
    useMaterial3: true,
    primaryColor: mainWhite,
    dividerColor: mainOrange,
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: mainWhite,
        onPrimary: mainWhite,
        secondary: mainBlack,
        onSecondary: mainBlack,
        error: Colors.deepOrange,
        onError: Colors.red,
        background: mainWhite,
        onBackground: mainWhite,
        surface: mainWhite,
        onSurface: mainWhite),
    scaffoldBackgroundColor: mainWhite,
    textTheme: TextTheme(
      bodySmall: TextStyle(color: mainBlack, fontSize: 14),
      bodyMedium: TextStyle(color: mainBlack, fontSize: 18),
      bodyLarge: TextStyle(color: mainBlack, fontSize: 20),
    ),
    appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(color: mainBlack, size: 25),
        backgroundColor: mainWhite,
        iconTheme: IconThemeData(color: mainBlack, size: 25),
        toolbarHeight: 80,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: mainWhite,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
            systemNavigationBarColor: mainWhite),
        titleTextStyle: TextStyle(
            color: mainBlack, fontSize: 22, fontWeight: FontWeight.bold)),
    iconTheme: IconThemeData(color: mainBlack, size: 25),
    chipTheme: const ChipThemeData(backgroundColor: Colors.white60),
    listTileTheme: ListTileThemeData(
      dense: false,
      minVerticalPadding: 0,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      tileColor: mainWhite,
      textColor: mainBlack,
      selectedColor: mainBlack.withOpacity(0.7),
      selectedTileColor: selectedColor,
    ),
    buttonTheme: ButtonThemeData(buttonColor: mainBlack),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            foregroundColor: mainBlack,
            backgroundColor: Colors.transparent)),
    cardTheme: CardTheme(color: mainWhite, elevation: 1),
    bottomSheetTheme: BottomSheetThemeData(
        modalBackgroundColor: mainWhite, backgroundColor: mainWhite));

/// Dark Theme
/// ///////////////////////////////////////////////////
HexColor mainDark = HexColor('#262424');

ThemeData darkTheme() => ThemeData(
    useMaterial3: true,
    primaryColor: mainDark,
    dividerColor: mainOrange,
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: mainDark,
        onPrimary: mainDark,
        secondary: mainWhite,
        onSecondary: mainWhite,
        error: Colors.deepOrange,
        onError: Colors.red,
        background: mainDark,
        onBackground: mainDark,
        surface: mainDark,
        onSurface: mainDark),
    scaffoldBackgroundColor: mainDark,
    textTheme: TextTheme(
      bodySmall: TextStyle(color: mainWhite, fontSize: 14),
      bodyMedium: TextStyle(color: mainWhite, fontSize: 18),
      bodyLarge: TextStyle(color: mainWhite, fontSize: 20),
    ),
    appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(color: mainWhite, size: 25),
        backgroundColor: darkBlack,
        // backgroundColor: mainDark,
        iconTheme: IconThemeData(color: mainWhite, size: 25),
        toolbarHeight: 80,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: darkBlack,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: darkBlack),
        elevation: 0,
        titleTextStyle: TextStyle(
            color: mainWhite, fontSize: 22, fontWeight: FontWeight.bold)),
    iconTheme: IconThemeData(color: mainWhite.withOpacity(0.5), size: 25),
    chipTheme: const ChipThemeData(backgroundColor: Colors.black87),
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: mainWhite.withOpacity(0.5),
        selectionColor: mainOrange,
        selectionHandleColor: mainOrange),

    datePickerTheme: DatePickerThemeData(
      backgroundColor: mainBlack,
      dayForegroundColor: MaterialStateProperty.all(mainWhite),
      dayOverlayColor: MaterialStateProperty.all(Colors.grey),
      dayStyle: TextStyle(color: mainWhite, fontSize: 14),
      headerForegroundColor: mainWhite,
      headerBackgroundColor: darkBlack,
      todayBackgroundColor: MaterialStateProperty.all(mainWhite),
      headerHeadlineStyle: TextStyle(color: mainWhite),
      rangePickerHeaderBackgroundColor: Colors.orange,
      rangePickerHeaderHeadlineStyle: TextStyle(color: mainWhite),
      rangePickerHeaderForegroundColor: Colors.orange,
      rangePickerBackgroundColor: mainOrange,
      rangeSelectionOverlayColor: MaterialStateProperty.all(mainWhite),
      rangePickerHeaderHelpStyle: TextStyle(color: mainWhite),
      rangeSelectionBackgroundColor: mainWhite,
      rangePickerSurfaceTintColor: mainOrange,
      shadowColor: mainWhite,
      yearBackgroundColor: MaterialStateProperty.all(mainBlack),
      yearStyle: TextStyle(color: mainOrange),
      yearForegroundColor: MaterialStateProperty.all(mainOrange),
      yearOverlayColor: MaterialStateProperty.all(mainWhite),
      todayForegroundColor: MaterialStateProperty.all(mainOrange),
      weekdayStyle: TextStyle(color: mainWhite.withOpacity(0.5), fontSize: 15),
    ),
    listTileTheme: ListTileThemeData(
      tileColor: mainDark,
      textColor: mainWhite,
      selectedColor: Colors.white54,
      selectedTileColor: Colors.black12,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: mainBlack,
    ),
    buttonTheme: ButtonThemeData(buttonColor: mainWhite),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(
        Colors.white54,
      ),
      backgroundColor: MaterialStateProperty.all(
        Colors.black,
      ),
    )),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: mainDark)),
    cardTheme: CardTheme(color: mainDark, elevation: 1),
    bottomSheetTheme: BottomSheetThemeData(
        modalBackgroundColor: mainDark, backgroundColor: mainDark));
