import 'dart:ffi';

import 'package:intl/intl.dart';

class ItunesModel {
  final String trackName;
  final String artistName;
  final String artworkUrl100;
  final String previewUrl;
  final String releaseDate;
  final dynamic trackPrice;

  ItunesModel({
    required this.trackName,
    required this.artistName,
    required this.artworkUrl100,
    required this.previewUrl,
    required this.releaseDate,
    required this.trackPrice
  });

  // Usually , creating models is good to handle, maintain , acces data easily.
  // here I created model for accessing itunes response values by keys easily throughout the project
  factory ItunesModel.fromJson(Map<String, dynamic> json) {
    return ItunesModel(
      trackName: json['trackName'] ?? "Unknown Track",
      artistName: json['artistName'] ?? "Unknown Field",
      artworkUrl100: json['artworkUrl100'] ?? "", // image provied to the song
      previewUrl: json['previewUrl'] ?? "null", // some seconds of music will play
      releaseDate: json['releaseDate'] ?? "",
      trackPrice: json['trackPrice'] ?? 0.0
    );
  }

  static String formatDate(String isoDate) { // parsing  date from iso format to usual format
    DateTime dateTime = DateTime.parse(isoDate);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
}
