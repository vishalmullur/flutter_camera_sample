import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sample_camera/model/ImageFile.dart';
import 'package:sample_camera/ui/CameraPreviewPage.dart';
import 'package:sample_camera/utils/ConnectivityUtils.dart';

class CameraPage extends StatefulWidget {
  final CameraDescription camera;

  const CameraPage({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_){
      checkForFailedUploads();
    });

    initCameraController();
  }

  void initCameraController() {
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onTakePictureClicked() async {
    try {
      await _initializeControllerFuture;

      final image = await _controller.takePicture();

      await uploadPictureToServer(image.path);

      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CameraPreviewPage(
            imagePath: image.path,
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  void checkForFailedUploads() async {
    print("Checking for failed uploads");
    var imageBox = await Hive.openBox("imageBox");

    print("There are ${imageBox.values.length} un-uploaded images");
    imageBox.values.map((e) => {
      print(e)
    });
  }

  Future<void> uploadPictureToServer(String imageFilePath) async {
    bool isConnectionAvailable = await ConnectivityUtils().checkConnectivity();
    if (isConnectionAvailable) {
      // Code for uploading the image to server
    } else {
      storeImageLocally(imageFilePath);
    }
  }

  // Store the image in db
  void storeImageLocally(String imageFilePath) async {
    var imageBox = await Hive.openBox("imageBox");

    var imageFileObject = ImageFile(DateTime.now().millisecondsSinceEpoch, imageFilePath, false);
    imageBox.put("image_${DateTime.now().millisecondsSinceEpoch}", imageFileObject);

    print("There are ${imageBox.values.length} un-uploaded images");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onTakePictureClicked,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
