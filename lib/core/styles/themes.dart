import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'colors.dart';

class ThemeService{

  final lightTheme = ThemeData(
    dialogBackgroundColor: lightScaffoldBackgroundColor,
    scaffoldBackgroundColor: lightScaffoldBackgroundColor,
    primaryColor: primaryColor,
    fontFamily: 'Tajawal',
    brightness: Brightness.light,
    dividerColor: lightDivideColor,
    backgroundColor: lightContainerGridOfCompleteShopColor,
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.normal
      ),
      enabledBorder: InputBorder.none,
      border: InputBorder.none,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: lightScaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor:unselectedItemColorBottomNavigationBar,
      backgroundColor: colorBottomNavigationBar,
    ),
    buttonTheme: const ButtonThemeData(
        colorScheme: ColorScheme.dark(),
        buttonColor: Color(0xFF1E1E1C),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: const Color(0xFF1E1E1C),
      dividerColor: primaryColor,

    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: primaryColor,
      ),
      backgroundColor: lightScaffoldBackgroundColor,
      titleTextStyle: TextStyle(
          fontSize: 20,
          color: primaryColor,
          fontWeight: FontWeight.bold
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFFA4AAAD)),
      )
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 14,
        color: primaryColor,
        fontWeight: FontWeight.bold,
        fontFamily: 'Tajawal',
      ),
      bodyText2: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: lightPrimaryTextColor,
          fontFamily: 'Tajawal'
      ),
      headline1: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: lightHintTextColor,
          fontFamily: 'Tajawal'
      ),
      headline2: TextStyle(
          fontSize: 16,
          color: lightTextButtonColor,
          fontFamily: 'Tajawal'
      ),
      headline3: const TextStyle(
          fontSize: 16,
          color: Color(0xFF727676),
          fontFamily: 'Tajawal'
      ),
    ),
  );

  final darkTheme = ThemeData(
    dialogBackgroundColor: scaffoldBackgroundColor,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    primaryColor: primaryColor,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: hintTextFormColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      hintStyle: TextStyle(
          color: hintTextFormColor,
          fontSize: 16,
          fontWeight: FontWeight.normal
      ),
      enabledBorder: InputBorder.none,
      border: InputBorder.none,
    ),
    backgroundColor: containerGridOfCompleteShopColor,
    fontFamily: 'Tajawal',
    brightness: Brightness.dark,
    dividerColor: divideColorDark,

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor:unselectedItemColorBottomNavigationBar,
      backgroundColor: colorBottomNavigationBarDark,
    ),
    buttonTheme: const ButtonThemeData(
        colorScheme: ColorScheme.light(),
        buttonColor: Colors.white
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      dividerColor: primaryColor,
    ),
    cardColor: const Color(0xFF1E1E1C),
    appBarTheme: AppBarTheme(
      elevation: 10,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: primaryColor,
      ),
      backgroundColor: scaffoldBackgroundColor,
      titleTextStyle: TextStyle(
          fontSize: 20,
          color: primaryColor,
          fontWeight: FontWeight.bold
      ),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 14,
        color: primaryColor,
        fontWeight: FontWeight.bold,
        fontFamily: 'Tajawal',
      ),
      bodyText2: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
          fontFamily: 'Tajawal'
      ),
      headline1: TextStyle(
          fontSize: 14,
          color: hintTextFormColor,
          fontFamily: 'Tajawal'
      ),
      headline2: TextStyle(
          fontSize: 16,
          color: darkTextButtonColor,
          fontFamily: 'Tajawal'
      ),
      headline3: const TextStyle(
          fontSize: 16,
          color: Color(0xFFA4AAAD),
          fontFamily: 'Tajawal'
      ),

    ),

  );

  final _getStorage = GetStorage();

  final _darkThemeKey = 'isDarkTheme';

  void saveThemeData(bool isDarkMode) {

    _getStorage.write(_darkThemeKey, isDarkMode);

  }
  bool isSavedDarkMode() {
    return _getStorage.read(_darkThemeKey) ?? true;
  }

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeData(!isSavedDarkMode());
  }
}

