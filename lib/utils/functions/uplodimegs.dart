// ignore_for_file: unused_local_variable, unnecessary_nullable_for_final_variable_declarations

import 'dart:io';

import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';

pickSingleImageFromGallery() async {
  final XFile? file = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 70,
    maxHeight: 512,
    maxWidth: 512,
  );
  if (file != null) {
    return File(file.path);
  } else {
    return null;
  }
}

pickMultipleImagesFromGallery() async {
  final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage(
    // imageQuality: 70,
    // maxHeight: 512,
    // maxWidth: 512,
  );
  if (pickedFiles != null) {
    return pickedFiles.map((xfile) => File(xfile.path)).toList();
  } else {
    return null;
  }
}
