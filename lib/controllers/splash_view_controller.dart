import 'package:get/get.dart';
import 'package:musix/api_service/itune_api_service.dart';
import 'package:musix/controllers/itune_controller.dart';
import 'package:musix/screens/home_page.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateToHome();
  }

  void navigateToHome() async {
    await Future.delayed(Duration(seconds: 2));
    // Get.put(ItunesController(itunesService: ItunesService()));
    Get.offAll(HomeScreen());
  }
}
