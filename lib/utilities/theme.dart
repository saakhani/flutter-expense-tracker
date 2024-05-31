import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData trackCashTheme() {
  ColorScheme colorSchemeTemp = ColorScheme.fromSeed(seedColor: Colors.cyan);
  return ThemeData(
    colorScheme: colorSchemeTemp,
    textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: colorSchemeTemp.onSurface,
          fontSize: 30,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: colorSchemeTemp.onSurface,
          fontSize: 18,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          fontSize: 18,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: FontWeight.w400,
        ),
        bodyLarge: TextStyle(
          fontSize: 20,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: FontWeight.w600,
        )),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: colorSchemeTemp.primary,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 8))),
  );
}

InputDecoration textFieldTheme(
    String label, IconData icon, BuildContext context) {
  return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      labelText: label,
      labelStyle: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      floatingLabelStyle: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: Theme.of(context).colorScheme.primary),
      border: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(16)),
      filled: true,
      fillColor: Theme.of(context).colorScheme.surfaceContainer,
      prefixIcon: Icon(
        icon,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 1.5)
        ),
        );
      
}
