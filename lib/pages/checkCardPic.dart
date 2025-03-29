import 'package:flutter/material.dart';
// import 'camera.dart';

class CheckCardPic extends StatelessWidget {
  // final String imagePath;

  const CheckCardPic({
    super.key,
    // this.imagePath = 'assets/picture/testPic.jpg',
    // required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              "Are you satisfied with this picture?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8806D8),
              ),
            ),
            // const SizedBox(height: 20),
            // Container(
            //   alignment: Alignment.center,
            //   child: Align(
            //     alignment: Alignment.center,
            //     child: Image.asset(
            //       'assets/picture/testPic.jpg',
            //       width: 300,
            //       height: 500,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
