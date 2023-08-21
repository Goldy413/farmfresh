import 'dart:io';

import 'package:farmfresh/module/product_module/product_detail_module/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension BuildContextHelper on BuildContext {
  void hideKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }
}

extension DateTimeHelper on DateTime {
  /// Return a string representing [date] formatted according to our locale
  /// and internal format.
  String toStringFormat(String format) {
    return DateFormat(format).format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension FileNameExtension on File {
  String getFileName() {
    String fileName = path.split('/').last;
    return fileName;
  }
}

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension Amount on double {
  String toformat() {
    var price = this;
    return "₹ ${price.toStringAsFixed(2)}";
  }
}

extension Price on ProductItem {
  getPrice({isSingleLine = false}) {
    return actualPrice != discountPrice
        ? Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '₹ ${actualPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                isSingleLine
                    ? const TextSpan(text: " ")
                    : const TextSpan(text: "\n"),
                TextSpan(
                  text: '₹ ${discountPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 17.0, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )
        : discountPrice == 0.0
            ? Text(
                '₹ $discountPrice',
                style: const TextStyle(
                    fontSize: 17.0, fontWeight: FontWeight.w600),
              )
            : Text(
                '₹ $actualPrice',
                style: const TextStyle(
                    fontSize: 17.0, fontWeight: FontWeight.w600),
              );
  }
}
