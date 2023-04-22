import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ndialog/ndialog.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

Widget buildNumberTextField(
  String deco,
  TextEditingController ctrl, {
  bool enabled = true,
}) {
  return TextField(
    decoration: InputDecoration(labelText: deco),
    controller: ctrl,
    textAlign: TextAlign.center,
    keyboardType: TextInputType.number,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly,
      ThousandsFormatter(),
    ],
    enabled: enabled,
  );
}

void buildSnackbar(
  BuildContext c, {
  String title = "Oh Damn!",
  String msg =
      "Something bad happened and the developer was to lazy to tell you what it was ...",
  ContentType? ct,
}) {
  var snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: msg,
      contentType: ct ?? ContentType.failure,
    ),
  );

  ScaffoldMessenger.of(c).showSnackBar(snackBar);
}

NDialog buildGetTimeInSecondsDlg(
  BuildContext c,
  TextEditingController ctrl,
  String title,
  String descriptor,
) {
  return NDialog(
    dialogStyle: DialogStyle(titleDivider: true),
    title: Text(title),
    content: buildNumberTextField(descriptor, ctrl),
    actions: <Widget>[
      ElevatedButton(
        child: const Text("OK"),
        onPressed: () => Navigator.pop(c, "OK"),
      ),
    ],
  );
}

copyToClipboardWithNotification(BuildContext c, String txt) {
  Clipboard.setData(ClipboardData(text: txt));
  buildSnackbar(
    c,
    title: "Wohoo!",
    msg: "Copied to clipboard:\n$txt",
    ct: ContentType.success,
  );
}

ElevatedButton buildColoredButton(
  Color c,
  String text,
  VoidCallback? onPressed,
) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(backgroundColor: c),
    child: Text(text),
  );
}

PopupMenuItem buildMenuItem(String text, Function() param1) {
  return PopupMenuItem(
    onTap: param1,
    child: Text(text),
  );
}

String genRandomNumberAsFormattedText({int min = 10000, int max = 1000000}) {
  final f = ThousandsFormatter();
  final val = f.formatEditUpdate(
    const TextEditingValue(),
    TextEditingValue(text: (Random().nextInt(max) + min).toString()),
  );

  return val.text;
}
