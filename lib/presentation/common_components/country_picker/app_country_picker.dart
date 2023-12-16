import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constants/app_colors.dart';
import 'country_list_builder.dart';

showAppCountryPicker(
  BuildContext context, {
  Country? selectedCountry,
  bool showCountryCode = true,
  required String title,
  required Function(Country value) onSelect,
}) {
  showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      // ),
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: Platform.isAndroid? 0.97.sh: 0.94.sh,
            decoration: BoxDecoration(
              color: AppColors().white,
              // borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: CountryListBuilder(title: title, selectedCountry: selectedCountry, onSelect: onSelect,showCountryCode: showCountryCode,),
          ),
        );
      }).whenComplete(() => FocusScope.of(context).unfocus());
}
