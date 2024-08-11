
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/api_service/itune_api_service.dart';
import 'package:musix/api_service/itunes_country_code_service.dart';
import 'package:musix/controllers/music_play_controller.dart';
import 'package:musix/models/country_model.dart';
import 'package:musix/models/itune_model.dart';
import 'package:musix/screens/home_page.dart';
import 'package:musix/screens/search_result_page.dart';
import 'package:musix/widgets/all_snack_bars.dart';


class ItunesController extends GetxController {
  var searchResults = <ItunesModel>[].obs; // for storing search results from search function
  var isLoading = false.obs; //  storing state of loading  for loading animation
  var noResultsFound = false.obs; // if no results found from api , it is set to "True"
  var mediaType = 'all'.obs;  // for media type parameter
  var resultOrder = 'top hits'.obs; // enabling result order ,old or new
  TextEditingController searchFieldController = TextEditingController(); // to observe the search field
  TextEditingController countrySearchController = TextEditingController(); // to set the region of the country
  var isFilter = false.obs; // filter option toggling

  var countries = <Country>[].obs; // full itunes supported countries.
  var selectedCountry = 'All'.obs; // the country which is currently selected

  final ItunesService itunesService; // initializing itunes service

  ItunesController({required this.itunesService});

  @override
  void onInit() async{
    super.onInit();
    print("onInit called");
    loadCountries(); // loading countries from json file in the start of the app
    // await search(true);
    // firstLoad();
  }

  bool isInitialScreen = true; // for checking initial screen
  // void firstLoad(){
  //   isInitialScreen = true;
  //   search();
  // }


  // void enableFilter(bool state){
  //   isFilter = state;
  //   update();
  // }

  /// Need to Develop
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

 // Initial List for randomly showing some tracks
  // by searching artist name in the start of the Apllication

  static List<String> initialSearchTermsList= [
    "AR Rahman",
    "Alan Walker",
    "Justin Beiber",
    "Imagine Dragons",
    "Taylor Swift",
    "Arijit Singh",
    "Ed Sheeran"
  ];

  static var randomIndex = Random().nextInt(initialSearchTermsList.length); // getting random index number upto list length
  var currentInitTerm = initialSearchTermsList[randomIndex].obs; // Used Random() to get it

  Future<void> search(bool initialLoad) async {
    try {

      // If the network is disconnected the snackbar bar indication will show , and the function stops
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        noInternetSnackbar(); // calling snackbar
        return;
      }

      // if the music is playing, it will before showing new results
      if(Get.find<MusicController>().isPlaying.value){
        Get.find<MusicController>().stop();
      }


      isLoading.value = true; // making it loading until the results shown
      noResultsFound.value = false;
      searchResults.clear(); // Clearing old results

      searchFieldController.text.isNotEmpty
        ? Get.to(SeacrhResultScreen()) // if there is some text in search means it should navigate to result showing page
        : Get.to(HomeScreen());  // else stay in the home screen itself

      // Here the itunesService search function is called with sending all values in their respective variables as params
       var results = searchFieldController.text.isNotEmpty
       // the search field text is passed to get search results
                  ? await itunesService.search(
                                  term: searchFieldController.text,
                                  media: mediaType.value,
                                  country: selectedCountry.value)
       //else: it will show initial loadings (by artist name)
                  : await itunesService.search(
                                  term: currentInitTerm.value,
                                  media: "music",
                                  country: selectedCountry.value);

      // print('format result --- $results');
      // Sorting the results According to result order filter
      if (results.isEmpty) {
        noResultsFound.value = true; // if empty noResultsFound will be true
      } else {
        if(resultOrder.value != 'top hits'){
          results.sort((a, b) {
            DateTime dateA = DateTime.parse(a.releaseDate); // sorting by release date
            DateTime dateB = DateTime.parse(b.releaseDate);
            return resultOrder.value == "new releases"
                ? dateB.compareTo(dateA) // toggling between new and old results
                : dateA.compareTo(dateB);
          });
        }
        // Finally Results is added Seacrh Reasults
        searchResults.addAll(results);
      }
    } catch (e) { // if error arrives the noResultsFound will be true , to avoiding errors
      noResultsFound.value = true;
    } finally {
      isLoading.value = false; // at last the loading will be false
      isInitialScreen = false;
    }
  }

  void updateMediaType(String newMediaType) { // user triggers this function by selecting value in dropdown
    if (newMediaType != mediaType.value) {
      mediaType.value = newMediaType; // mediaType obs variable is updating
      if (searchFieldController.text.isNotEmpty) {
        search(false); // when search field is not empty only , this function called
      }
    }
  }

  void updateResultOrder(String newResultOrder) { // user triggers this function by selecting value in dropdown
    if (newResultOrder != resultOrder.value) {
      resultOrder.value = newResultOrder; // resultOrder obs variable is updating
      if (searchFieldController.text.isNotEmpty) {
        search(false); // when search field is not empty only , this function called
      }
    }
  }

  void updateCountry(String newCountry) {  // user triggers this function by setting region
    if (newCountry != selectedCountry.value) {
      selectedCountry.value = newCountry; // selectedCountry obs variable is updating
      print("coun -- ${selectedCountry.value}");
      if (searchFieldController.text.isNotEmpty) {
        search(false); // when search field is not empty only , this function called
      }
    }
  }

  void clearFilter(){ // clearing all current filters
    if (mediaType.value != "all" || resultOrder.value != "top hits") { // check if filtering is applied
      mediaType.value = "all"; // setting back to default
      resultOrder.value = "top hits"; // setting back to default
        if (searchFieldController.text.isNotEmpty) {
          search(false); // calling function again to get default results for the current term in search controller
        }
    }
  }

  void loadCountries() async { // for showing total list of countries in the dropdown(searchable)
    try {
      var service = CountryService(); // Initializing Service variable with CountryService Service
      var loadedCountries = await service.loadCountryCodes();
      countries.value = loadedCountries; //values loaded to countries obs variable
    } catch (e) {
      print('Error loading countries: $e');
    }
  }

  // void updateCountry2(String? value) {
  //   selectedCountry.value = value ?? '';
  // }

}

