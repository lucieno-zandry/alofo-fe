import 'package:get/get.dart';

class SettingsNavbarState extends GetxController {
  int activeIndex = 0;

  setActiveIndex(int newActiveIndex) {
    activeIndex = newActiveIndex;
    update();
  }
}
