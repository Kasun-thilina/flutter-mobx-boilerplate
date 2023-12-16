import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

/// Load network image with caching capabilities
class AppNetworkImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final BlendMode? blendMode;
  final double? borderRadius;

  const AppNetworkImage({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.blendMode,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return url != null
        ? url!.isEmpty
            ? SizedBox(
                width: width,
                height: height,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius ?? 0),
                child: CachedNetworkImage(
                  imageUrl: url!,
                  width: width,
                  height: height,
                  color: color,
                  colorBlendMode: blendMode ?? BlendMode.color,
                  fit: fit ?? BoxFit.cover,
                  placeholder: (context, url) => SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const Center(child: CircularProgressIndicator()).paddingAll(25.w)),
                  errorWidget: (context, url, error) {
                    debugPrint("Error: $error");
                    return const Icon(Icons.error);
                  },
                ),
              )
        : SizedBox(
            width: width,
            height: height,
          );
  }
}
