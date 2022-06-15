import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_cropper_for_web/image_cropper_for_web.dart';

List<PlatformUiSettings>? buildProfileUISettings(BuildContext context) {
  return [
    WebUiSettings(
      context: context,
      presentStyle: CropperPresentStyle.dialog,
      boundary: Boundary(
        width: 250,
        height: 250,
      ),
      viewPort: ViewPort(width: 200, height: 200, type: 'circle'),
      enableExif: true,
      enableZoom: true,
      showZoomer: true,
    ),
  ];
}

List<PlatformUiSettings>? buildBackgroundUISettings(BuildContext context) {
  return [
    WebUiSettings(
      context: context,
      presentStyle: CropperPresentStyle.dialog,
      boundary: Boundary(
        //width: 500,
        height: 200,
      ),
      viewPort: ViewPort(width: 300, height: 120, type: 'rectangle'),
      enableExif: true,
      enableZoom: true,
      showZoomer: true,
    ),
  ];
}

List<PlatformUiSettings>? buildSocialUISettings(BuildContext context) {
  return [
    WebUiSettings(
      context: context,
      presentStyle: CropperPresentStyle.dialog,
      boundary: Boundary(
        width: 500,
        height: 500,
      ),
      viewPort: ViewPort(width: 480, height: 480, type: 'square'),
      enableExif: true,
      enableZoom: true,
      showZoomer: true,
    ),
  ];
}
