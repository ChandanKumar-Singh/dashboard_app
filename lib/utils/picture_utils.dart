import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '/constants.dart';
import '/constants/app_constants.dart';
import '/constants/assets_constant.dart';
import '/utils/logger.dart';

Widget assetSvg(String path,
        {BoxFit? fit, Color? color, double? width, double? height}) =>
    SvgPicture.asset(
      'assets/svg/$path',
      fit: fit ?? BoxFit.contain,
      color: color,
      width: width,
      height: height,
    );
/*Widget assetRive(String path, {BoxFit? fit}) => RiveAnimation.asset(
      'assets/rive/$path',
      fit: fit ?? BoxFit.contain,
    );*/
Widget assetLottie(String path,
        {BoxFit? fit,
        double? width,
        double? height,
        LottieDelegates? delegates}) =>
    Lottie.asset(
      'assets/lottie/$path',
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
      delegates: delegates,
    );

Widget assetImages(String path,
        {BoxFit? fit, Color? color, double? width, double? height}) =>
    Image.asset(
      'assets/images/$path',
      fit: fit ?? BoxFit.contain,
      color: color,
      width: width,
      height: height,
    );

ImageProvider assetImageProvider(String path, {BoxFit? fit}) =>
    AssetImage('assets/images/$path');

ImageProvider netImageProvider(String path,
        {BoxFit? fit, Color? color, double? width, double? height}) =>
    NetworkImage(path);

CachedNetworkImage buildCachedNetworkImage(String image,
    {double? ph,
    double? pw,
    double? borderRadius,
    BoxFit? fit,
    bool fullPath = false,
    BoxShape? shape,
    String? placeholder}) {
  return CachedNetworkImage(
    imageUrl: image,
    fit: fit ?? BoxFit.cover,
    imageBuilder: (context, image) => ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: Container(
        width: pw ?? 50,
        height: ph ?? 50,
        decoration: BoxDecoration(
            shape: shape ?? BoxShape.rectangle,
            image: DecorationImage(image: image, fit: fit ?? BoxFit.cover)),
      ),
    ),
    placeholder: (context, url) => Center(
      child: SizedBox(
        height: ph ?? 50,
        width: pw ?? 100,
        child: Center(
            child: CircularProgressIndicator(
                color: Theme.of(Get.context!)
                    .colorScheme
                    .primary
                    .withOpacity(0.5))),
      ),
    ),
    errorWidget: (context, url, error) => ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: Center(
          child: SizedBox(
              height: ph ?? 50,
              width: pw ?? 100,
              child: assetImages(placeholder ?? PNGAssets.appLogo))),
    ),
    cacheManager: CacheManager(Config("${AppConst.appName}_$image",
        stalePeriod: const Duration(days: 30))),
  );
}
