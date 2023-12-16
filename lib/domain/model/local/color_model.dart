import 'dart:ui';

class ColorType {
  static const normal = "normal";
  static const multiColor = "multi_color";
  static const transparent = "transparent";
  static const pickerColor = "picker_color";
  static const picker = "picker";
}

class AppColorModel {
  Color color;

  bool isSelected = false;

  String type;

  ///Used to keep track if a variant is present from this color
  bool hasVariants=false;

  // List<Product> variants = [];

  // List<SizeItem>? sizeChart;

  AppColorModel(
      {required this.color, required this.isSelected, this.type = ColorType.normal,this.hasVariants=false});
}
