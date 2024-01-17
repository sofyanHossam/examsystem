
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class DialogService {
  static Future<void> showErrorDialog(BuildContext context, String error) async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Error',
      desc: error,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    )..show();
  }
}
