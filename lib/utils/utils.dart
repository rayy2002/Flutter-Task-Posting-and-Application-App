// ignore_for_file: unused_import

import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Utils {
  Size getScreenSize() {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  }

  showSnackBar({required BuildContext context, required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 6,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        content: SizedBox(
          width: getScreenSize().width,
          child: Text(
            content,
            maxLines: 4,
            overflow: TextOverflow.clip,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }

  String getUid() {
    return (100000 + Random().nextInt(10000)).toString();
  }
}
