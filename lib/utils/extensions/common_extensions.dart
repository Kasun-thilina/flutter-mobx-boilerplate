import 'package:flutter/material.dart';

extension TextEditingExtensions on TextEditingController {
  void setText(String txt) {
    text = txt;
    selection = TextSelection.collapsed(offset: txt.length);
  }
  void selectAll() {
    if (text.isEmpty) return;
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }
}

extension ColorX on Color {
  String toHex() => '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
}