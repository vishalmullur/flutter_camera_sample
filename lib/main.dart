import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_camera/model/ImageFile.dart';
import 'package:sample_camera/ui/CameraPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  await Hive.initFlutter();
  Hive.registerAdapter(ImageFileAdapter());

  runApp(MyApp(firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription firstCamera;

  MyApp(this.firstCamera);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CameraPage(camera: firstCamera),
    );
  }
}
