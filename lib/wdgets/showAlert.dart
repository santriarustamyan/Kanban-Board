import 'package:flutter/material.dart';

Future<void> showAlertDialog(BuildContext context,
    {String? title, String? content, Function? onPressButton}) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text(title!, textAlign: TextAlign.center),
          content: Text(
            content!,
          ),
          actions: [
            TextButton(child: Text("OK"), onPressed: () => onPressButton!())
          ]);
    },
  );
}
