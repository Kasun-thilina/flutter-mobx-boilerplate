import 'package:country_flags/country_flags.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/icons.dart';
import '../../../utils/hex_color.dart';
import '../buttons/ripple_button.dart';

class CountryListBuilder extends StatefulWidget {
  final String title;
  final Country? selectedCountry;
  final bool showCountryCode;
  final ValueChanged<Country> onSelect;

  const CountryListBuilder({
    super.key,
    this.showCountryCode = true,
    required this.title,
    required this.selectedCountry,
    required this.onSelect,
  });

  @override
  State<CountryListBuilder> createState() => _CountryListBuilderState();
}

class _CountryListBuilderState extends State<CountryListBuilder> {
  final CountryService _countryService = CountryService();

  late List<Country> _countryList;
  late TextEditingController _searchController;
  late List<Country> _filteredList;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _countryList = _countryService.getAll();
    _filteredList = <Country>[];
    _filteredList.addAll(_countryList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 6.h,
            width: 70.w,
            decoration:
                BoxDecoration(color: AppColors().grey6, borderRadius: BorderRadius.all(Radius.circular(3.h))),
          ),
        ),
        Text(
          widget.title,
          style: context.textTheme.displayLarge,
        ).paddingTop(27.h),
        TextFormField(
          controller: _searchController,
          keyboardType: TextInputType.text,
          cursorColor: AppColors().black,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
              filled: true,
              hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors().fontGrey),
              hintText:
                  widget.showCountryCode ? context.strings.searchForCode : context.strings.searchForCountry,
              fillColor: HexColor("#F6F6F6"),
              border: InputBorder.none,
              suffixIcon: _searchController.text.isNotEmpty
                  ? RippleButton(
                      borderRadius: 50,
                      onTap: () {
                        _searchController.text = "";
                        setState(() => _filteredList = _countryList);
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
                color: AppColors().lightBlue,
              )),
          onChanged: _filterSearchResults,
        ).paddingTop(20.h),
        Expanded(
          child: ListView.builder(
              itemCount: _filteredList.length,
              primary: false,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    widget.onSelect(_filteredList[index]);
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                _filteredList[index].countryCode == "XK" ||
                                        _filteredList[index].countryCode == "AC"
                                    ? Image.asset(
                                        AssetIcons.defaultFlag,
                                        height: 18.w,
                                        width: 23.w,
                                      )
                                    : CountryFlag.fromCountryCode(
                                        _filteredList[index].countryCode,
                                        height: 18.w,
                                        width: 23.w,
                                      ).paddingStart(5.w),
                                // Text(Utils.countryCodeToEmoji(countryList[index].countryCode), style: context.textTheme.headlineSmall,),
                                widget.showCountryCode
                                    ? Row(
                                        children: [
                                          SizedBox(
                                            width: 45.w,
                                            child: Text(
                                              "(+${_filteredList[index].phoneCode})",
                                              style: context.textTheme.headlineSmall,
                                              overflow: TextOverflow.clip,
                                            ),
                                          ).paddingStart(15.w),
                                          Text(
                                            "-",
                                            style: context.textTheme.headlineSmall
                                                ?.copyWith(color: AppColors().fontLightGrey),
                                          ).paddingSymmetric(horizontal: 8.w),
                                        ],
                                      )
                                    : fetchEmptyWidget().paddingStart(20.w),
                                Expanded(
                                  child: Text(
                                    _filteredList[index].name,
                                    style: context.textTheme.headlineSmall?.copyWith(
                                        color: widget.showCountryCode
                                            ? AppColors().fontLightGrey
                                            : AppColors().black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Radio(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: _filteredList[index].countryCode == widget.selectedCountry?.countryCode,
                              groupValue: true,
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                return AppColors().primaryColor;
                              }),
                              onChanged: (value) {
                                widget.onSelect(_filteredList[index]);
                              }),
                        ],
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColors().grey,
                      ).paddingSymmetric(vertical: 20.h),
                    ],
                  ),
                );
              }).paddingTop(20.h),
        )
      ],
    ).paddingSymmetric(vertical: 1.h, horizontal: 30.w);
  }

  void _filterSearchResults(String query) {
    List<Country> searchResult = <Country>[];
    final CountryLocalizations? localizations = CountryLocalizations.of(context);

    if (query.trim().isEmpty) {
      searchResult.addAll(_countryList);
    } else {
      searchResult = _countryList.where((c) => c.startsWith(query.trim(), localizations)).toList();
    }

    setState(() => _filteredList = searchResult);
  }
}
