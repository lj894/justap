import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

List<PlatformUiSettings>? buildProfileUISettings(BuildContext context) {
  return [
    WebUiSettings(
      context: context,
      presentStyle: CropperPresentStyle.dialog,
      boundary: const CroppieBoundary(
        width: 250,
        height: 250,
      ),
      viewPort: const CroppieViewPort(width: 200, height: 200, type: 'circle'),
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
      boundary: const CroppieBoundary(
        //width: 500,
        height: 200,
      ),
      viewPort:
          const CroppieViewPort(width: 300, height: 120, type: 'rectangle'),
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
      boundary: const CroppieBoundary(
        width: 500,
        height: 500,
      ),
      viewPort: const CroppieViewPort(width: 480, height: 480, type: 'square'),
      enableExif: true,
      enableZoom: true,
      showZoomer: true,
    ),
  ];
}
