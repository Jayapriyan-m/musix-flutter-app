import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:musix/models/country_model.dart';

class CountryService {
  static Map<String, dynamic> countryList = {}; // initializing country list
  Future<List<Country>> loadCountryCodes() async {
    try {
      final jsonString = await rootBundle.loadString('assets/country_code.json'); // loading json file
      final Map<String, dynamic> jsonMap = json.decode(jsonString) as Map<String, dynamic>; // decoding json file
      // countryList = jsonMap;

      // Here using country model , the values in json is stored in the structured form of country model to access
      // country code by country names and vice versa . by factory method
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



