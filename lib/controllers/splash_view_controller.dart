import 'package:get/get.dart';
import 'package:musix/api_service/itune_api_service.dart';
import 'package:musix/controllers/itune_controller.dart';
import 'package:musix/controllers/music_play_controller.dart';
import 'package:musix/screens/home_page.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();

    // Calling the method to navigate to the HomeScreen
    navigateToHome();
  }

  // navigate to the HomeScreen after a delay
  void navigateToHome() async {
    // await Future.delayed(Duration(seconds: 3));

    // initializing the MusicController in the mean time
    Get.put(MusicController());

    // Get.put(ItunesController(itunesService: ItunesService()));

    // Adding a delay before performing the next actions
    await Future.delayed(Duration(seconds: 3));

    // Triggering the search in ItunesController to load initial data
    await Get.find<ItunesController>().search(true);

    // finally navigating to the HomeScreen after setting up controllers
    Get.offAll(HomeScreen());
  }
}
