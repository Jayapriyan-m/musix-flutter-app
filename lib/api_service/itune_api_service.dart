import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:musix/models/itune_model.dart';


class ItunesService {
  static const String baseUrl = 'https://itunes.apple.com/search';  // Itunes API URL

  Future<List<ItunesModel>> search({required String term, String? media, String? country}) async {

    final mediaParam = media != null || media != 'all' ? '&media=$media' : '';  // Media Parameter with initial condition check
    final countryParam = country != null && country != 'All' ? '&country=$country' : ''; // providing country details with initial condition check

    if (kDebugMode) {
      print("params --- term: $term, media: $mediaParam, country: $countryParam");
    }

    final response = await http.get(Uri.parse('$baseUrl?term=$term$countryParam$mediaParam')); // processing api operation for given params

    if (response.statusCode == 200) { //if success
      final data = json.decode(response.body);
      if (kDebugMode) {
        print('http response --- $data');
      }
      // Here using itunes model , the response is stored in the structured form of Itunes model. by factory method
      return (data['results'] as List).map((item) => ItunesModel.fromJson(item)).toList();
    } else {  // not success -> return empty list
      return [];
    }
  }
}
