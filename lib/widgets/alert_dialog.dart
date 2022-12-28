import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, title, message) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogWithCallback(BuildContext context, title, message, callback) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () async {
      await callback()();
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [okButton],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showConfirmDialog(BuildContext context, title, message, callback) {
  Widget okButton = TextButton(
    child: Text("Confirm"),
    onPressed: () async {
      await callback()();
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [okButton, cancelButton],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showNFCScanDialog(BuildContext context, callback) {
  Widget cancelButton = TextButton(
    child: Text("CANCEL"),
    onPressed: () async {
      await callback()();
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text("WAITING FOR NFC TAG")]),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.add_to_home_screen_outlined,
          size: 80,
        ),
        SizedBox(height: 30),
        Text(
          "Hold your NFC tag near the device.",
          style: TextStyle(fontSize: 12),
        )
      ],
    ),
    actions: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        cancelButton,
      ])
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
