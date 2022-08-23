import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String errorMessage) {
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: ((context) {
        return AlertDialog(
          title: Text("We're sorry"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Something's wrong"),
                SizedBox(
                  height: 10,
                ),
                Text(errorMessage),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text("Go back"),
            ),
          ],
        );
      }));
}
