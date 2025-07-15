import 'package:get/get.dart';

class AuthDialogState extends GetxController {
  int active = 0;

  setActive(int newActive) {
    active = newActive;
    update();
  }
}
