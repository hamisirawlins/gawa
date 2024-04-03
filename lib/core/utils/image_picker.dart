import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  try {
    final XFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (XFile == null) return null;
    return File(XFile.path);
  } catch (e) {
    return null;
  }
}
