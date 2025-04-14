import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pic2thai/pages/createCardDetail.dart';
import 'package:pic2thai/pages/camera.dart';

class CheckCardPic extends StatelessWidget {
  final String imagePath;

  const CheckCardPic({
    super.key,
    // this.imagePath = 'assets/picture/testPic.jpg',
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Are you satisfied with this picture?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8806D8),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                20,
              ), // ปรับขนาดมุมมนตามต้องการ
              child: Image.file(
                File(imagePath), // ใช้ภาพจาก path ที่ส่งมา
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
              // child: Image.asset(
              //   'assets/picture/testPic.jpg',
              //   width: 300,
              //   height: 300,
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
