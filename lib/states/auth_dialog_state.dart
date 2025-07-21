import 'package:get/get.dart';

class AuthDialogState extends GetxController {
  AuthDialogState({this.active = 0}) : history = [active];

  int active;
  List<int> history;

  setActive(int newActive) {
    history = [...history, newActive];
    active = newActive;
    update();
  }

  setHistory(List<int> newHistory) {
    history = newHistory;
    update();
  }

  previous() {
    if (history.isEmpty) return;
    history = history.sublist(0, history.length - 1);
    active = history.last;
    update();
  }

  updateState({List<int>? newHistory, int? newActive}) {
    if (newHistory != null) {
      history = newHistory;
    }

    if (newActive != null) {
      active = newActive;
    }

    update();
  }
}
