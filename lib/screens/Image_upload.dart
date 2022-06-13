import 'dart:io';
// //if (dart.library.io) 'dart:io'
// if (dart.library.html) 'dart:html' as html;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:justap/utils/ui_helper.dart'
    if (dart.library.io) 'package:justap/utils/mobile_ui_helper.dart'
    if (dart.library.html) 'package:justap/utils/web_ui_helper.dart';
import 'package:justap/services/remote_services.dart';
import 'package:justap/widgets/alert_dialog.dart';
import 'package:justap/screens/all.dart';

class ImageUpload extends StatefulWidget {
  final String title;

  const ImageUpload({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title:
              Text(widget.title, style: const TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0.0),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _body()),
        ],
      ),
    );
  }

  Widget _body() {
    if (_croppedFile != null || _pickedFile != null) {
      return _imageCard();
    } else {
      return _uploaderCard();
    }
  }

  Widget _imageCard() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kIsWeb ? 24.0 : 16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
                child: _image(),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          _menu(),
          const SizedBox(height: 16.0),
          _saveButton(),
        ],
      ),
    );
  }

  Widget _image() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else if (_pickedFile != null) {
      final path = _pickedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _menu() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FloatingActionButton(
          onPressed: () {
            _cropImage('PROFILE');
            //_cropImage('BACKGROUND');
          },
          mini: true,
          backgroundColor: Colors.black,
          tooltip: 'Crop',
          child: const Icon(Icons.crop),
        ),
        const SizedBox(width: 20),
        FloatingActionButton(
          onPressed: () {
            _clear();
          },
          mini: true,
          backgroundColor: Colors.grey,
          tooltip: 'Delete',
          child: const Icon(Icons.delete),
        ),
      ],
    );
  }

  Widget _uploaderCard() {
    return Center(
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SizedBox(
          width: kIsWeb ? 380.0 : 320.0,
          height: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DottedBorder(
                    radius: const Radius.circular(12.0),
                    borderType: BorderType.RRect,
                    dashPattern: const [8, 4],
                    color: Theme.of(context).highlightColor.withOpacity(0.4),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Theme.of(context).highlightColor,
                            size: 80.0,
                          ),
                          const SizedBox(height: 24.0),
                          Text(
                            'Upload an image to start',
                            style: kIsWeb
                                ? Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        color: Theme.of(context).highlightColor)
                                : Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color:
                                            Theme.of(context).highlightColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    _uploadImage();
                  },
                  child: const Text('Upload'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _saveButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          textStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      child: const Text("Save"),
      onPressed: () async {
        //try {
        // await RemoteServices.updateProfileImage();
        File imageFile;
        if (_croppedFile != null) {
          if (kIsWeb) {
            imageFile = Image.network(_croppedFile!.path) as File;
          } else {
            imageFile = File(_croppedFile!.path);
          }
          await RemoteServices.updateProfileImage(imageFile);
        }
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileScreen(),
              settings: const RouteSettings(name: '/')),
        );
        //} catch (e) {
        //showAlertDialog(context, "Error", "$e");
        //}
      },
    );
  }

  Future<void> _cropImage(type) async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 300,
        // maxWidth: 500,
        // maxHeight: 500,
        uiSettings: type == "PROFILE"
            ? buildProfileUISettings(context)
            : type == "BACKGROUND"
                ? buildBackgroundUISettings(context)
                : buildSocialUISettings(context),
      );
      if (croppedFile != null) {
        setState(() {
          print('cropped');
          print(croppedFile);
          _croppedFile = croppedFile;
        });
      }
    }
  }

  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  void _clear() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
  }
}
