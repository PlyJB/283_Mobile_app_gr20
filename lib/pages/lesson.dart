import 'package:flutter/material.dart';
import 'package:pic2thai/models/conversation_model.dart';
import 'package:pic2thai/main.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:sqflite/sqflite.dart';

class Lesson extends StatefulWidget {
  final Database database;
  final ConvoModel convo;

  Lesson({super.key, required this.convo, required this.database});

  @override
  State<Lesson> createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> increaseLearnCount() async {
  await widget.database.rawUpdate(
    'UPDATE user_stats SET learn_count = learn_count + 1'
  );
}

  Future _speak(String text) async {
    await flutterTts.setLanguage("th-TH"); // สำหรับภาษาไทย
    await flutterTts.setSpeechRate(0.5); // ความเร็วในการพูด
    await flutterTts.speak(text);

  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final convo = widget.convo;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          convo.title,
          style: AppTextStyles.body.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF8806D8),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: convo.articles.length,
          itemBuilder: (context, index) {
            final article = convo.articles[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFF8806D8)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          article.thai,
                          style: AppTextStyles.body.copyWith(
                            fontSize: 22,
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.volume_up_rounded,
                          color: const Color(0xFF8806D8),
                        ),
                        onPressed: () {
                          _speak(article.thai); // อ่านข้อความเมื่อกด
                          increaseLearnCount(); // เพิ่มจำนวนการเรียนรู้
                        },
                      ),
                    ],
                  ),
                  Text(
                    article.pheonetic,
                    style: const TextStyle(
                      color: const Color(0xFF8806D8),
                      fontSize: 14,
                    ),
                  ),
                  Divider(
                    color: const Color(0xFF8806D8), // สีเส้น
                    thickness: 1, // ความหนา
                  ),
                  const SizedBox(height: 8),
                  Text(article.english, style: const TextStyle(fontSize: 14)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
