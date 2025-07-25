import 'package:alofo/classes/auth_dialog_item.dart';
import 'package:alofo/widgets/create_password_dialog/create_password_dialog.dart';
import 'package:alofo/widgets/create_username_dialog/create_username_dialog.dart';
import 'package:alofo/widgets/email_confirmation_code_dialog/email_confirmation_code_dialog.dart';
import 'package:alofo/widgets/insert_client_code_dialog/insert_client_code_dialog.dart';
import 'package:alofo/widgets/login_dialog/login_dialog.dart';
import 'package:alofo/widgets/password_forgotten_dialog.dart';
import 'package:get/get.dart';

const authDialogMap = {
  'login': AuthDialogItem(isMandatory: false, widget: LoginDialog(), index: 0),
  'email_confirmation_code': AuthDialogItem(
    isMandatory: true,
    widget: EmailConfirmationCodeDialog(),
    index: 1,
  ),
  'create_username': AuthDialogItem(
    isMandatory: true,
    widget: CreateUsernameDialog(),
    index: 2,
  ),
  'create_password': AuthDialogItem(
    isMandatory: true,
    widget: CreatePasswordDialog(),
    index: 3,
  ),
  'password_forgotten': AuthDialogItem(
    isMandatory: false,
    widget: PasswordForgottenDialog(),
    index: 4,
  ),
  'insert_client_code': AuthDialogItem(
    isMandatory: false,
    widget: InsertClientCodeDialog(),
    index: 5,
  ),
};

class AuthDialogState extends GetxController {
  AuthDialogState({this.active = 0, this.onSuccess}) : history = [active];

  int active;
  List<int> history;
  Function()? onSuccess;

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
