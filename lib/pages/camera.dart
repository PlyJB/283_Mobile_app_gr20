import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pic2thai/pages/createCardDetail.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class CameraPage extends StatefulWidget {
  final Database database;
  const CameraPage({super.key, required this.database});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    PermissionStatus status = await Permission.camera.request();
    if (status.isGranted) {
      _setupCamera();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Permission is needed.")),
      );
    }
  }

  Future<void> _setupCamera() async {
    cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      cameraController = CameraController(
        cameras.first,
        ResolutionPreset.medium,
      );
      await cameraController?.initialize();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(child: CameraPreview(cameraController!)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _takePicture,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.white,
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 40,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _takePicture() async {
    if (!cameraController!.value.isInitialized) return;

    try {
      final image = await cameraController!.takePicture();

      final directory = await getApplicationDocumentsDirectory();
      final filename = 'pic2thai_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImagePath = p.join(directory.path, filename);

      // คัดลอกภาพไปเก็บถาวร
      await File(image.path).copy(savedImagePath);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Picture taken successfully')),
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CreatecardDetail(
            database: widget.database,
            imagePath: savedImagePath,
          ),
        ),
      );
    } catch (e) {
      debugPrint("Fail due to: $e");
    }
  }
}
