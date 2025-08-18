import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/models.dart' as models;

class FrontOfficeState extends GetxController {
  models.User? _user;
  bool userStateIsKnown = false;
  BuildContext context;

  FrontOfficeState({required this.context});

  models.User? get user {
    return _user;
  }

  void setUser(models.User? user) {
    _user = user;
    userStateIsKnown = true;
    update();
  }
}
