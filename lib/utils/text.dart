import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_dashboard/utils/sizedbox_utils.dart';
import 'package:my_dashboard/utils/sizedbox_utils.dart';
import 'package:my_dashboard/utils/sizedbox_utils.dart';
import 'package:my_dashboard/utils/sizedbox_utils.dart';
import 'package:my_dashboard/utils/sizedbox_utils.dart';

Text capText(
  String text, {
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
  TextStyle? style,
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  double? letterSpacing,
  double? lineHeight,
  TextDecoration? decoration,
}) =>
    Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines ?? 3,
      style: GoogleFonts.ubuntu(
        textStyle: style ??
            getTheme.textTheme.bodySmall!.copyWith(
                fontWeight: fontWeight,
                letterSpacing: letterSpacing,
                color: color ?? getTheme.textTheme.bodyMedium!.color,
                fontSize: fontSize,
                height: lineHeight,
                decoration: decoration),
      ),
    );
Text bodyMedText(
  String text, {
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
  TextStyle? style,
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  double? letterSpacing,
  double? lineHeight,
  TextDecoration? decoration,
}) =>
    Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines ?? 3,
      style: GoogleFonts.ubuntu(
        textStyle: style ??
            getTheme.textTheme.bodyMedium!.copyWith(
                fontWeight: fontWeight,
                letterSpacing: letterSpacing,
                color: color,
                fontSize: fontSize,
                height: lineHeight,
                decoration: decoration),
      ),
    );
Text bodyLargeText(
  String text, {
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
  TextStyle? style,
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  double? letterSpacing,
  double? lineHeight,
  TextDecoration? decoration,
}) =>
    Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines ?? 3,
      style: GoogleFonts.ubuntu(
        textStyle: style ??
            getTheme.textTheme.bodyLarge!.copyWith(
                fontWeight: fontWeight ?? FontWeight.bold,
                letterSpacing: letterSpacing,
                color: color,
                fontSize: fontSize,
                height: lineHeight,
                decoration: decoration),
      ),
    );
Text titleLargeText(
  String text, {
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
  TextStyle? style,
  Color? color,
  double? fontSize = 18,
  FontWeight? fontWeight,
  double? letterSpacing,
  double? lineHeight,
  TextDecoration? decoration,
}) =>
    Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines ?? 3,
      style: GoogleFonts.ubuntu(
        textStyle: style ??
            getTheme.textTheme.titleLarge!.copyWith(
                fontWeight: fontWeight ?? FontWeight.bold,
                letterSpacing: letterSpacing,
                color: color,
                fontSize: fontSize,
                height: lineHeight,
                // fontFamily: 'Sansita',
                decoration: decoration),
      ),
    );

class ShadowText extends StatelessWidget {
  ShadowText({required this.data, this.shadowData, this.style});

  final Widget data;
  final Widget? shadowData;
  final TextStyle? style;

  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          // new Positioned(
          //   top: 1.0,
          //   left: 1.0,
          //   bottom: 1,
          //   child: data,
          // ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            child: data,
          ),
          // new BackdropFilter(
          //   filter: new ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
          //   child: data,
          // ),
        ],
      ),
    );
  }
}
