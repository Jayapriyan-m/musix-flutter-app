import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:musix/models/country_model.dart';

class CountryService {
  static Map<String, dynamic> countryList = {};
  Future<List<Country>> loadCountryCodes() async {
    try {
      final jsonString = await rootBundle.loadString('assets/country_code.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      countryList = jsonMap;

      List<Country> countries = jsonMap.entries
          .map((entry) => Country(name: entry.key, code: entry.value as String))
          .toList();

      return countries;
    } catch (e) {
      print('Error loading country codes: $e');
      rethrow;
    }
  }
}



