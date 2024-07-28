import 'package:get/get.dart';
import 'package:musix/screens/home_page.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateToHome();
  }

  void navigateToHome() async {
    await Future.delayed(Duration(seconds: 2));
    Get.offAll(HomeScreen());
  }
}
