import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ChipModel {
  String name;
  String? id;
  String? type;
  bool isSelected = false;
  Color? color;
  Color? selectedColor;
  Color? textColor;
  String? icon;

  ChipModel({this.id, required this.name, required this.isSelected, this.color,this.selectedColor, this.textColor, this.icon,this.type});
}
