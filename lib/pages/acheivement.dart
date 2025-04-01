import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pic2thai/models/acheivement_model.dart'; // ตรวจสอบให้แน่ใจว่า import ไฟล์นี้

class AchievementPage extends StatefulWidget {
  final int collectedCards;
  final int learnedConversations;

  AchievementPage({required this.collectedCards, required this.learnedConversations});

  @override
  _AchievementPageState createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  List<AchievementModel> achievements = AchievementModel.getAchievements();

  @override
  void initState() {
    super.initState();
    checkAndUnlockAchievements();
  }

  void checkAndUnlockAchievements() {
    setState(() {
      for (var achievement in achievements) {
        if (!achievement.isReceived && achievement.condition(widget.collectedCards, widget.learnedConversations)) {
          achievement.isReceived = true;
          achievement.receivedDate = DateTime.now();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<AchievementModel> receivedAchievements = achievements.where((achievement) => achievement.isReceived).toList();

    return Scaffold(
      appBar: AppBar(title: Text('🏆 Achievements')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: receivedAchievements.isEmpty
            ? Center(child: Text('ยังไม่มี Achievements ที่ได้รับ 😢'))
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
