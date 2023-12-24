import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppConstant {
  static Color appbarcolor = Colors.lightBlue;
  static Color? backgroundcolor = Colors.lightBlue[200];

  static TextStyle textfancyheader =
      GoogleFonts.sansitaSwashed(fontSize: 40, color: Colors.white);
  static TextStyle textred =
      GoogleFonts.sansitaSwashed(fontSize: 40, color: Colors.red);

  static TextStyle textheader =
      GoogleFonts.sansitaSwashed(fontSize: 35, color: Colors.white);

  static TextStyle texterror = const TextStyle(
      color: Colors.white, fontSize: 16, fontStyle: FontStyle.italic);
  static TextStyle texterror1 = const TextStyle(
      color: Color.fromARGB(255, 255, 0, 0),
      fontSize: 16,
      fontStyle: FontStyle.italic);
  static TextStyle texterror2 = const TextStyle(
      color: Color.fromARGB(255, 255, 0, 0),
      fontSize: 20,
      fontStyle: FontStyle.italic);

  static TextStyle textlink = const TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textbody =
      const TextStyle(color: Colors.black, fontSize: 18);

  static TextStyle textbodyfocus =
      const TextStyle(color: Colors.black, fontSize: 25);

  static bool isDate(String str) {
    try {
      var inputFormat = DateFormat('dd/MM/yyyy');
      var date = inputFormat.parseStrict(str);
      return true;
    } catch (e) {
      print('loi');
      return false;
    }
  }
}
