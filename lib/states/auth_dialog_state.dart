import 'package:get/get.dart';

class AuthDialogState extends GetxController {
  AuthDialogState({this.active = 0});
  
  int active;

  setActive(int newActive) {
    active = newActive;
    update();
  }
}
