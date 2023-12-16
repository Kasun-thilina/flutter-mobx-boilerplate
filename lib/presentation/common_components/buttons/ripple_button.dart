import 'package:flutter/material.dart';

class RippleButton extends StatelessWidget {
  final Widget child;
  final double? borderRadius;
  final bool? isCustomRadius;
  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomLeftRadius;
  final double? bottomRightRadius;
  final Color color;
  final BoxBorder? border;
  final BorderSide? borderSide;
  final GestureTapCallback? onTap;
  final double? paddingVertical;
  final double? paddingHorizontal;
  final double? elevation;

  const RippleButton({
    Key? key,
    this.paddingVertical,
    this.paddingHorizontal,
    this.isCustomRadius = false,
    this.topLeftRadius = 0,
    this.topRightRadius = 0,
    this.bottomLeftRadius = 0,
    this.bottomRightRadius = 0,
    this.elevation,
    this.border,
    this.borderSide,
    required this.onTap,
    this.borderRadius,
    required this.color,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      elevation: elevation ?? 0,
      shape: borderSide != null
          ? RoundedRectangleBorder(
              side: borderSide!,
              borderRadius: isCustomRadius!
                  ? BorderRadius.only(
                      topLeft: Radius.circular(topLeftRadius!),
                      topRight: Radius.circular(topRightRadius!),
                      bottomRight: Radius.circular(bottomRightRadius!),
                      bottomLeft: Radius.circular(bottomLeftRadius!),
                    )
                  : BorderRadius.circular(borderRadius ?? 0))
          : RoundedRectangleBorder(
              borderRadius: isCustomRadius!
                  ? BorderRadius.only(
                      topLeft: Radius.circular(topLeftRadius!),
                      topRight: Radius.circular(topRightRadius!),
                      bottomRight: Radius.circular(bottomRightRadius!),
                      bottomLeft: Radius.circular(bottomLeftRadius!),
                    )
                  : BorderRadius.circular(borderRadius ?? 0)),
      child: InkWell(
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0)),
              border: border),
          padding: EdgeInsets.symmetric(vertical: paddingVertical ?? 0, horizontal: paddingHorizontal ?? 0),
          child: child,
        ),
      ),
    );
  }
}
