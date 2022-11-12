import 'dart:convert';

import 'package:bike_customerv2/main.dart';

String getTokenAuthenFromSharedPrefs() {
  return sharedPreferences.getString('Token')!;
}

int getCuctomerIDFromSharedPrefs() {
  return sharedPreferences.getInt('UserID')!;
}
