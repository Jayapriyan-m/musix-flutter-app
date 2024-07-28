import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:musix/models/itune_model.dart';


class ItunesService {
  static const String baseUrl = 'https://itunes.apple.com/search';

  Future<List<ItunesModel>> search({required String term, String? media}) async {
    if (kDebugMode) {
      print("params --- term: $term, media: $media");
    }
    final mediaParam = media != null || media != 'all' ? '&media=$media' : '';
    final response = await http.get(Uri.parse('$baseUrl?term=$term$mediaParam'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (kDebugMode) {
        print('http response --- $data');
      }
      return (data['results'] as List).map((item) => ItunesModel.fromJson(item)).toList();
    } else {
      return [];
    }
  }
}
