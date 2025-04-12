import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pic2thai/pages/createCard.dart';
import 'package:sqflite/sqflite.dart';
import 'package:permission_handler/permission_handler.dart'; // เพิ่ม import

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
    _requestPermissions(); // เรียกฟังก์ชันขออนุญาต
  }

  // ฟังก์ชันขออนุญาต
  Future<void> _requestPermissions() async {
    // ตรวจสอบการอนุญาต
    PermissionStatus status = await Permission.camera.request();

    // ถ้าอนุญาตให้ใช้กล้อง
    if (status.isGranted) {
      _setupCamera(); // เรียกฟังก์ชันตั้งค่ากล้อง
    } else {
      // แจ้งเตือนหรือจัดการกรณีไม่อนุญาต
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("ต้องการอนุญาตให้ใช้กล้อง")));
    }
  }

  Future<void> _setupCamera() async {
    List<CameraDescription> _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      setState(() {
        cameras = _cameras;
        cameraController = CameraController(
          cameras.first,
          ResolutionPreset.medium,
        );
      });
      await cameraController?.initialize().then((_) {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.black, // Set the background to black
      appBar: AppBar(
        // title: const Text('กล้อง'),
        backgroundColor: Colors.black, // AppBar background is black
        elevation: 0, // Remove shadow for flat look
      ),
      body: Column(
        children: [
          // Full-screen camera preview
          Expanded(child: CameraPreview(cameraController!)),

          // Camera capture button at the bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _takePicture,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: Colors.white, // Button color
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
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Picture taken successfully')));

      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (context) => Createcard(
                database: widget.database,
                imagePath: image.path, // ส่ง path ไปตรงนี้
              ),
        ),
      );
      debugPrint(image.path);
    } catch (e) {
      debugPrint("ถ่ายรูปผิดพลาด: $e");
    }
  }
}
