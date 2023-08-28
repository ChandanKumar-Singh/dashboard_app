import 'package:flutter/material.dart';
import 'package:my_dashboard/constants.dart';
import 'package:my_dashboard/utils/picture_utils.dart';

showImageDialog(BuildContext context, String image,
    {bool fromNet = false,
    bool showCancel = false,
    VoidCallback? onCancel,
    Color bgColor = Colors.transparent,
    BoxFit? fit,
    bool showCircular = false}) {
  showDialog(
      context: context,
      builder: (_) => Center(
            child: Container(
              padding: const EdgeInsets.all(defaultPadding + defaultPadding),
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 100),
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(25)),
                    child: fromNet
                        ? buildCachedNetworkImage(image,
                            shape: showCircular ? BoxShape.circle : null,
                            fit: fit ?? BoxFit.contain)
                        : assetImages(image, fit: BoxFit.cover),
                  ),
                  if (showCancel)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton.filled(
                              onPressed: () {
                                Navigator.pop(context);
                                if (onCancel != null) onCancel();
                              },
                              icon: const Icon(Icons.clear))
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ));
}
