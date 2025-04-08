// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double dynamicWidth(double val) => MediaQuery.sizeOf(this).width * val;
  double dynamicHeight(double val) => MediaQuery.sizeOf(this).height * val;

  ThemeData get theme => Theme.of(this);
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingAll => EdgeInsets.all(dynamicHeight(0.01));
  EdgeInsets get paddingBottom => EdgeInsets.only(bottom: dynamicHeight(0.01));
  EdgeInsets get paddingTop => EdgeInsets.only(top: dynamicHeight(0.01));
  EdgeInsets get paddingLeft => EdgeInsets.only(left: dynamicHeight(0.01));
  EdgeInsets get paddingRight => EdgeInsets.only(right: dynamicHeight(0.01));
}

extension StringLocalization on String {
  String get locale => this.tr();
}

extension SnackBarExtension on BuildContext {
  Future<void> showFailureSnackBar(String message) async {
    if (!mounted) return;
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          backgroundColor: Colors.black38,
          textColor: Colors.white,
          label: "LocaleKeys.homepage_back_txt.locale",
          onPressed: () {
            ScaffoldMessenger.of(this).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  Future<void> showSuccessSnackBar(String message) async {
    if (!mounted) return; // Check if the widget is still mounted
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          textColor: Colors.white,
          backgroundColor: Colors.black38,
          label: "LocaleKeys.homepage_back_txt.locale",
          onPressed: () {
            ScaffoldMessenger.of(this).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  Future<void> myShowDialog(Function showFunc) async {
    return showDialog(
      context: this,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text('Are you sure you want to delete your account?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await showFunc();
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
