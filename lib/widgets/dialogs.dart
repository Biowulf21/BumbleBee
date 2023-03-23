import 'package:flutter/material.dart';

abstract class IDialogHelper {}

class DialogHelper {
  void showCustomDialog(
      {required BuildContext context,
      required String title,
      Icon? icon,
      required String content,
      required List<Widget> dialogActions}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: icon,
            title: Text(title),
            content: Text(content),
            actions: dialogActions,
          );
        });
  }
}
