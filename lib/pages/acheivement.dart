import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pic2thai/models/acheivement_model.dart'; // ตรวจสอบให้แน่ใจว่า import ไฟล์นี้
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
    final List<Map<String, dynamic>> cards = await widget.database.query('cards');
    collectedCards = cards.length;

    checkAndUnlockAchievements();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getLearnCount() async {
  final List<Map<String, dynamic>> result = await widget.database.query('user_stats');
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
    List<AchievementModel> receivedAchievements = achievements.where((achievement) => achievement.isReceived).toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: receivedAchievements.isEmpty
            ? Center(child: Text('No achievements received.'))
            : ListView.builder(
                itemCount: receivedAchievements.length,
                itemBuilder: (context, index) {
                  final achievement = receivedAchievements[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Image.asset(achievement.iconPath, width: 50),
                      title: Text(
                        achievement.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'ได้รับเมื่อ: ${achievement.receivedDate != null ? DateFormat('dd MMM yyyy').format(achievement.receivedDate!) : 'ยังไม่ได้รับ'}',
                      ),
                      tileColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
