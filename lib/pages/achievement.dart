import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pic2thai/models/achievement_model.dart';
import 'package:sqflite/sqflite.dart';

class AchievementPage extends StatefulWidget {
  final Database database;

  AchievementPage({required this.database});

  @override
  _AchievementPageState createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  List<AchievementModel> achievements = AchievementModel.getAchievements();
  int collectedCards = 0; // จำนวนการ์ดที่เก็บรวบรวม
  int learnCount = 0; // จำนวนการเรียนรู้ที่เก็บรวบรวม
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCollectedCards();
    getLearnCount();
  }

  Future<void> loadCollectedCards() async {
    final List<Map<String, dynamic>> cards = await widget.database.query(
      'cards',
    );
    collectedCards = cards.length;

    checkAndUnlockAchievements();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getLearnCount() async {
    final List<Map<String, dynamic>> result = await widget.database.query(
      'user_stats',
    );
    learnCount = result.first['learn_count'];

    checkAndUnlockAchievements();
    setState(() {
      isLoading = false;
    });
  }

  void checkAndUnlockAchievements() {
    for (var achievement in achievements) {
      if (!achievement.isReceived &&
          achievement.condition(collectedCards, learnCount)) {
        achievement.isReceived = true;
        achievement.receivedDate = DateTime.now();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // กรองเฉพาะที่ได้แล้ว
    List<AchievementModel> receivedAchievements =
        achievements.where((achievement) => achievement.isReceived).toList();

    return Scaffold(
      backgroundColor: Color(0xFFF6F6FA),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            receivedAchievements.isEmpty
                ? Center(
                  child: Text(
                    'No achievements received.',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
                : GridView.builder(
                  itemCount: receivedAchievements.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                      final achievement = receivedAchievements[index];
                      return Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFF6F6FA),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Image.asset(
                                achievement.iconPath,
                                width: 100.w,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              achievement.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 4),
                            Text(
                              achievement.receivedDate != null
                                  ? DateFormat('dd MMM yyyy').format(achievement.receivedDate!)
                                  : '--, --,----',
                              style: TextStyle(
                                color: Color(0xFF8806D8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                  // itemBuilder: (context, index) {
                  //   final achievement = receivedAchievements[index];
                  //   return Column(
                  //     children: [
                  //       Container(
                  //         padding: EdgeInsets.all(8.w),
                  //         // height: 180,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(20),
                  //           color: Color(0xFFF6F6FA),
                  //         ),
                  //         child: Column(
                  //           children: [
                  //             Image.asset(achievement.iconPath, width: 100.w),
                  //             SizedBox(height: 8),
                  //             Text(
                  //               achievement.name,
                  //               style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.black,
                  //               ),
                  //               textAlign: TextAlign.center,
                  //             ),
                  //             SizedBox(height: 4),
                  //             Text(
                  //               ' ${achievement.receivedDate != null ? DateFormat('dd MMM yyyy').format(achievement.receivedDate!) : '--, --,----'}',
                  //               style: TextStyle(
                  //                 color: const Color(0xFF8806D8),
                  //                 fontSize: 12,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   );
                  // },
                ),
      ),
    );
  }
}
