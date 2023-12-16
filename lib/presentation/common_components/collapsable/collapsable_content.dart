import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/presentation/common_components/buttons/ripple_button.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';

import '../../../data/constants/app_colors.dart';

/// Area with top bar and default white rounded background
class CollapsableContent extends StatefulWidget {
  final String title;
  final Color? backgroundColor;
  final Color? openedColor;
  final Color? closedColor;
  final TextStyle? textStyle;
  final TextStyle? openedTextStyle;
  final bool canCollapse;
  final double? radius;
  final Widget? openedIcon;
  final Widget? closedIcon;
  final Widget? titlePrefix;
  final Widget child;
  final Widget? bottomChild;

  const CollapsableContent(
      {Key? key,
      required this.title,
      required this.child,
      this.backgroundColor,
      this.titlePrefix,
      this.textStyle,
      this.openedTextStyle,
      this.radius,
      this.openedColor,
      this.closedColor,
      this.openedIcon,
      this.closedIcon,
      this.bottomChild,
      this.canCollapse = true})
      : super(key: key);

  @override
  State<CollapsableContent> createState() => _CollapsableContentState();
}

class _CollapsableContentState extends State<CollapsableContent> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    if (!widget.canCollapse) {
      setState(() {
        isOpen = true;
      });
    }

    return Container(
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppColors().white,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(widget.radius ?? 7),
            bottomLeft: Radius.circular(widget.radius ?? 7),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RippleButton(
            onTap: () {
              if (widget.canCollapse) {
                setState(() {
                  isOpen = !isOpen;
                });
              }
            },
            topLeftRadius: widget.radius ?? 7,
            topRightRadius: widget.radius ?? 7,
            bottomLeftRadius: isOpen ? 0 : widget.radius ?? 7,
            bottomRightRadius: isOpen ? 0 : widget.radius ?? 7,
            isCustomRadius: true,
            paddingHorizontal: 20.w,
            paddingVertical: 15.h,
            color: isOpen
                ? widget.openedColor != null
                    ? widget.openedColor!
                    : AppColors().lightBlue10.withOpacity(0.5)
                : widget.closedColor != null
                    ? widget.closedColor!
                    : AppColors().blueGradient1,
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        widget.titlePrefix ?? fetchEmptyWidget(),
                        Expanded(
                          child: Text(
                            widget.title,
                            style: widget.openedTextStyle != null
                                ? isOpen
                                    ? widget.openedTextStyle
                                    : widget.textStyle
                                : widget.textStyle ??
                                    context.textTheme.titleSmall
                                        ?.copyWith(fontWeight: FontWeight.w600, color: AppColors().black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  widget.canCollapse
                      ? isOpen
                          ? widget.openedIcon ??
                              Icon(
                                Icons.keyboard_arrow_up,
                                color: AppColors().black,
                                size: 25.w,
                              )
                          : widget.closedIcon ??
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors().black,
                                size: 25.w,
                              )
                      : fetchEmptyWidget()
                ],
              ),
            ),
          ),
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              // switchInCurve: Curves.elasticOut,
              // switchOutCurve: Curves.slowMiddle,
              child: isOpen
                  ? Column(
                      key: const Key("contentArea"),
                      children: [
                        widget.child,
                        widget.bottomChild != null ? widget.bottomChild! : fetchEmptyWidget()
                      ],
                    )
                  : fetchEmptyWidget()),
        ],
      ),
    );
  }
}
