import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

import '../buttons/ripple_button.dart';
import '../empty_widget.dart';

class SearchBar extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;
  final VoidCallback onClear;

  const SearchBar({
    Key? key,
    this.controller,
    required this.onChanged,
    required this.onClear,
    this.onSubmitted,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController controller;
  bool clearButtonVisible=false;
  @override
  void initState() {
    controller = TextEditingController();
    controller.addListener(() {
      if(controller.text.isNotEmpty){
        setState(() {
          clearButtonVisible=true;
        });
      }else{
        setState(() {
          clearButtonVisible=false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      cursorColor: AppColors().black,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: widget.onSubmitted,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.only(top: 16.h),
          hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors().hintGrey),
          hintText: context.strings.search,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors().grey4)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors().grey4)),
          suffixIcon: clearButtonVisible
              ? RippleButton(
                  borderRadius: 50,
                  onTap: (){
                    controller.text="";
                    widget.onClear();
                  },
                  color: AppColors().hintGrey,
                  child: Icon(
                    Icons.close,
                    color: AppColors().white,
                    size: 13,
                  ),
                ).paddingAll(15.w)
              : fetchEmptyWidget(),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: AppColors().hintGrey,
          )),
      onChanged: widget.onChanged,
    );
  }

  @override
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
