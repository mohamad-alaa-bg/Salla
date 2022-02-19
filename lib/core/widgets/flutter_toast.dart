import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla/core/util/enum.dart';

void showToast({required String message, required ToastColor toastColor}) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: _toastColor(toastColor),
    textColor: Colors.white,
    timeInSecForIosWeb: 5,
    fontSize: 20,
  );
}

Color _toastColor(ToastColor toastColor) {
  Color color;
  switch (toastColor) {
    case ToastColor.success:
      {
        color = Colors.green;
        break;
      }
    case ToastColor.warning:
      {
        color = Colors.amber;
        break;
      }
    case ToastColor.error:
      {
        color = Colors.red;
        break;
      }
  }
  return color;
}
