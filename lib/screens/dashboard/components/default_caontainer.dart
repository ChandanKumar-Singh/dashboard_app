import 'package:flutter/material.dart';
import 'package:my_dashboard/constants.dart';

Widget defaultContainer(BuildContext context,
        {Widget? child,
        double? h,
        double? w,
        EdgeInsets? padding,
        GlobalKey<State<StatefulWidget>>? key}) =>
    Container(
        key: key,
        height: h,
        width: w,
        padding: padding ?? const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: child);
