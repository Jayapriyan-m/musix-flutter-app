import 'package:get/get.dart';
import 'package:musix/api_service/itune_api_service.dart';
import 'package:musix/controllers/itune_controller.dart';
import 'package:musix/controllers/music_play_controller.dart';
import 'package:musix/screens/home_page.dart';

class SplashController extends GetxController {
  @override
  void onInit() async{
    super.onInit();

    navigateToHome();
  }

  void navigateToHome() async {
    // await Future.delayed(Duration(seconds: 3));
    // // Get.put(ItunesController(itunesService: ItunesService()));
    // Get.put(MusicController());
    // await Get.find<ItunesController>().search(true);
    // Get.offAll(HomeScreen());

    Get.put(MusicController());
    // Get.put(ItunesController(itunesService: ItunesService()));

    await Future.delayed(Duration(seconds: 3));
    await Get.find<ItunesController>().search(true);

    // Navigate to HomeScreen
    Get.offAll(HomeScreen());

  }
}
