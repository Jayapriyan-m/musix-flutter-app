
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/api_service/itune_api_service.dart';
import 'package:musix/models/itune_model.dart';
import 'package:musix/widgets/all_snack_bars.dart';


class ItunesController extends GetxController {
  var searchResults = <ItunesModel>[].obs;
  var isLoading = false.obs;
  var noResultsFound = false.obs;
  var mediaType = 'all'.obs;
  var resultOrder = 'top hits'.obs;
  TextEditingController searchFieldController = TextEditingController();
  var isFilter = false.obs;

  final ItunesService itunesService;

  ItunesController({required this.itunesService});

  @override
  void onInit() {
    super.onInit();
    search();
  }

  bool isInitialScreen = true;
  // void firstLoad(){
  //   isInitialScreen = true;
  // }


  // void enableFilter(bool state){
  //   isFilter = state;
  //   update();
  // }

  // For Theme Toggling dark, light mode
  var isDarkMode = true.obs;

  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  //media type list
  List<String> mediaTypeList = [
    'All',
    'Movie',
    'Podcast',
    'Music',
    'MusicVideo',
    'Audiobook',
    'ShortFilm',
    'TvShow',
    'Software',
    'Ebook',
  ];

  //result Order List
  List<String> resultOrderList = [
    'Top Hits',
    'New Releases',
    'Oldest'
  ];

  static List<String> initialSearchTermsList= [
    "AR Rahman",
    "Alan Walker",
    "Justin Beiber",
    "Imagine Dragons",
    "Taylor Swift",
    "Arijit Singh",
    "Ed Sheeran"
  ];

  static var randomIndex = Random().nextInt(initialSearchTermsList.length);
  String currentInitTerm = initialSearchTermsList[randomIndex];

  void search() async {
    try {

      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        noInternetSnackbar();
        return;
      }

      isLoading.value = true;
      noResultsFound.value = false;
      searchResults.clear(); // Clearing old results

       var results = searchFieldController.text.isNotEmpty
                  ? await itunesService.search(term: searchFieldController.text, media: mediaType.value)
                  : await itunesService.search(term: currentInitTerm, media: mediaType.value);

      // print('format result --- $results');
      if (results.isEmpty) {
        noResultsFound.value = true;
      } else {
        if(resultOrder.value != 'top hits'){
          results.sort((a, b) {
            DateTime dateA = DateTime.parse(a.releaseDate);
            DateTime dateB = DateTime.parse(b.releaseDate);
            return resultOrder.value == "new releases"
                ? dateB.compareTo(dateA)
                : dateA.compareTo(dateB);
          });
        }
        searchResults.addAll(results);
      }
    } catch (e) {
      noResultsFound.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void updateMediaType(String newMediaType) {
    if (newMediaType != mediaType.value) {
      mediaType.value = newMediaType;
      if (searchFieldController.text.isNotEmpty) {
        search();
      }
    }
  }

  void updateResultOrder(String newResultOrder) {
    if (newResultOrder != resultOrder.value) {
      resultOrder.value = newResultOrder;
      if (searchFieldController.text.isNotEmpty) {
        search();
      }
    }
  }

  void clearFilter(){
    if (mediaType.value != "all" || resultOrder.value != "top hits") {
      mediaType.value = "all";
      resultOrder.value = "top hits";
        if (searchFieldController.text.isNotEmpty) {
          search();
        }
    }
  }


}

