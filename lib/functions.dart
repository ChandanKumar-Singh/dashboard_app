import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/logger.dart';

Future<PlatformFile?> pickImageLessThan3MB() async {
  // Pick an image from the gallery or the camera.
  FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
    allowMultiple: false,
    type: FileType.custom,
    allowedExtensions: ['jpg', 'png', 'jpeg'],
  );
  if (pickedFile != null && pickedFile.files.isNotEmpty) {
    PlatformFile file = pickedFile.files.first;
    infoLog(file.name.toString());
    infoLog(file.size.toString());
    infoLog(file.extension.toString());

    // If the file size is less than 3 MB, return the file.
    if (file.size < 3 * 1024 * 1024) {
      return file;
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content:
              Text("The file is too large. The maximum file size is 3 MB."),
        ),
      );
    }
  }
  return null;
}
