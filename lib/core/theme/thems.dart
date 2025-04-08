import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nimbus/colors/colors.dart';

class ThemsClass {
  // Light ve Dark Temaları Tanımlayın
  final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: bgColor,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green,
      brightness: Brightness.light,
    ).copyWith(secondary: Colors.blue),
    appBarTheme: AppBarTheme(
      backgroundColor: bgColor,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: darkBgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkBgColor,
        elevation: 5,
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: bgColor,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: Colors.black),
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: Colors.black),
      titleMedium: TextStyle(color: Colors.black),
      titleSmall: TextStyle(color: Colors.black),
      displayLarge: TextStyle(color: Colors.black),
      displayMedium: TextStyle(color: Colors.black),
      displaySmall: TextStyle(color: Colors.black),
      headlineLarge: TextStyle(color: Colors.black),
      headlineMedium: TextStyle(color: Colors.black),
      headlineSmall: TextStyle(color: Colors.black),
      labelLarge: TextStyle(color: Colors.black),
      labelMedium: TextStyle(color: Colors.black),
      labelSmall: TextStyle(color: Colors.black),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      fillColor: darkBgColor,
      hintStyle: GoogleFonts.poppins(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(darkIconColor),
      trackColor: WidgetStatePropertyAll(logoColor),
    ),
  );

  final ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: darkBgColor,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.red,
      brightness: Brightness.dark,
    ).copyWith(secondary: Colors.blue),
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: darkIconColor),
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      titleSmall: TextStyle(color: Colors.white),
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
      headlineLarge: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: Colors.white),
      labelLarge: TextStyle(color: Colors.white),
      labelMedium: TextStyle(color: Colors.white),
      labelSmall: TextStyle(color: Colors.white),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      toolbarTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: darkBgColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkBgColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(color: Colors.white),
      unselectedIconTheme: IconThemeData(color: Colors.white),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: darkBgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: darkBgColor,
        ),
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkBgColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: bgColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: bgColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: bgColor, width: 1),
      ),
    ),
    cardTheme: CardTheme(
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.black,
      textColor: Colors.black,
      selectedColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    dividerColor: Colors.white,
    dividerTheme: const DividerThemeData(
      color: Colors.white,
      thickness: 1,
      space: 0,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: darkBgColor,
      contentTextStyle: TextStyle(color: Colors.white),
      actionTextColor: Colors.white,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.white,
    ),
    checkboxTheme: const CheckboxThemeData(
      fillColor: WidgetStatePropertyAll(Colors.white),
      checkColor: WidgetStatePropertyAll(Colors.black),
    ),
    radioTheme: const RadioThemeData(
      fillColor: WidgetStatePropertyAll(Colors.white),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(darkIconColor),
      trackColor: WidgetStatePropertyAll(logoColor),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: Colors.white,
      selectionHandleColor: Colors.white,
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: Colors.white,
      selectedColor: Colors.white,
      secondarySelectedColor: Colors.white,
      disabledColor: Colors.white,
      selectedShadowColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: darkBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  );
}
