import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vhembe_gov/common/constant/image_constant.dart';
import 'package:vhembe_gov/common/widgets/common_loading_page.dart';

class CommonImageAsset extends StatelessWidget {
  final double? height;
  final double? webHeight;
  final double? width;
  final double? webWidth;
  final String? image;
  final BoxFit? webFit;
  final BoxFit? fit;
  final Color? color;
  final bool isWebImage;

  const CommonImageAsset({
    Key? key,
    @required this.image,
    this.webFit = BoxFit.cover,
    this.fit,
    this.height,
    this.webHeight,
    this.width,
    this.webWidth,
    this.color,
    this.isWebImage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isWebImage
        ? CachedNetworkImage(
            imageUrl: image!,
            height: webHeight,
            width: webWidth,
            fit: webFit,
            placeholder: (context, url) => const LoadingPage(),
            errorWidget: (context, url, error) => const CommonImageAsset(
              image: ImageConstant.appIcon,
              fit: BoxFit.contain,
            ),
          )
        : image!.split('.').last != 'svg'
            ? Image.asset(
                image!,
                fit: fit,
                height: height,
                width: width,
                color: color,
              )
            : SvgPicture.asset(
                image!,
                height: height,
                width: width,
                color: color,
              );
  }
}
