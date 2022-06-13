import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

List<PlatformUiSettings>? buildProfileUISettings(BuildContext context) {
  return [
    AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false),
    IOSUiSettings(
      title: 'Cropper',
    ),
  ];
}

List<PlatformUiSettings>? buildBackgroundUISettings(BuildContext context) {
  return [
    AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false),
    IOSUiSettings(
      title: 'Cropper',
    ),
  ];
}

List<PlatformUiSettings>? buildSocialUISettings(BuildContext context) {
  return [
    AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false),
    IOSUiSettings(
      title: 'Cropper',
    ),
  ];
}
