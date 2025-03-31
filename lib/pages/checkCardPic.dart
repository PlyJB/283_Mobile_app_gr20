import 'package:flutter/material.dart';
import 'package:pic2thai/pages/createCardDetail.dart';
// import 'package:pic2thai/pages/camera.dart';

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
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  20,
                ), // ปรับขนาดมุมมนตามต้องการ
                child: Image.asset(
                  'assets/picture/testPic.jpg',
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  // ไปต่อ (สร้างคำศัพท์หรือหน้าถัดไป)
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              CreatecardDetail(),
                      transitionsBuilder: (
                        context,
                        animation,
                        secondaryAnimation,
                        child,
                      ) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(1, 0),
                            end: Offset(0, 0),
                          ).animate(animation),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8806D8), // สีพื้นหลัง
                  foregroundColor: Colors.white, // สีตัวอักษรหรือไอคอน
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ), // ขนาดปุ่ม
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40), // มุมมน
                  ),
                ),
                child: Text("Yes"),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  // ไปต่อ (สร้างคำศัพท์หรือหน้าถัดไป)
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // สีพื้นหลัง
                  foregroundColor: Color(0xFF8806D8), // สีตัวอักษรหรือไอคอน
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ), // ขนาดปุ่ม
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40), // มุมมน
                  ),
                ),
                child: Text("Retake the photo"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
