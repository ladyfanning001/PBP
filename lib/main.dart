import 'package:alt_expense_tracker_app/expense_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final kcolorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(66, 44, 204, 225),
);

final kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color(0xFF181D2B),
);

void main() {
  runApp(
    MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id', 'ID'),
      ],
      // dark mode
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        scaffoldBackgroundColor: kDarkColorScheme.secondaryContainer,
        appBarTheme: const AppBarTheme().copyWith(
          color: kDarkColorScheme.primaryContainer,
          titleTextStyle: const TextStyle().copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.black,
          ),
        ),

      ),

      // light mode
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 249, 250, 251),
        appBarTheme: const AppBarTheme().copyWith(
          titleTextStyle: const TextStyle().copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        colorScheme: kcolorScheme,

        cardTheme: const CardThemeData().copyWith(
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      home: const ExpenseMainScreen(),
    ),
  );
}
